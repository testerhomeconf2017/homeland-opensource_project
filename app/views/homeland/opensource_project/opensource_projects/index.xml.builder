xml.instruct! :xml, version: "1.0"
xml.rss(version: "2.0"){
  xml.channel{
    xml.title "#{Setting.app_name} - #{t('plugin.opensource_project')}"
    xml.link opensource_projects_url
    xml.description "#{Setting.app_name} - #{t('plugin.opensource_project')}"
    xml.language('zh-CN')
      for opensource_project in @opensource_projects
        xml.item do
          xml.title opensource_project.title
          xml.description markdown(opensource_project.body)
          xml.author opensource_project.user&.login
          xml.pubDate(opensource_project.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link opensource_project_url(opensource_project)
          xml.guid opensource_project_url(opensource_project)
        end
      end
  }
}
