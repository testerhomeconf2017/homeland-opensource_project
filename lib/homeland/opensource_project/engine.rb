module Homeland
  module OpensourceProject
    class Engine < ::Rails::Engine
      isolate_namespace Homeland::OpensourceProject

      initializer 'homeland.opensource_project.init' do |app|
        if Setting.has_module?(:opensource_project)
          app.config.after_initialize do
            # Because need use I18n.t
            # must after Rails application initialized will get correct locale
            Homeland.register_plugin do |plugin|
              plugin.name              = 'opensource_project'
              plugin.display_name      = I18n.t('plugin.opensource_project')
              plugin.description       = 'A Press/News plugin for Homeland.'
              plugin.navbar_link       = true
              plugin.admin_navbar_link = true
              plugin.root_path         = "/opensource_projects"
              plugin.admin_path        = "/admin/opensource_projects"
            end
          end


          User.send :include, Homeland::OpensourceProject::UserMixin

          app.routes.prepend do
            mount Homeland::OpensourceProject::Engine => '/'
          end

          app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)
        end
      end
    end
  end
end
