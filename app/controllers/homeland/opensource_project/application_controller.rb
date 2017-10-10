module Homeland::OpensourceProject
  class ApplicationController < ::ApplicationController
    helper Homeland::OpensourceProject::ApplicationHelper

    def current_ability
      @current_ability ||= Homeland::OpensourceProject::Ability.new(current_user)
    end
  end
end
