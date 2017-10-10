module Homeland::OpensourceProject
  module UserMixin
    extend ActiveSupport::Concern

    included do
      action_store :like, :opensource_project, counter_cache: true, class_name: 'OpensourceProject'
    end
  end
end
