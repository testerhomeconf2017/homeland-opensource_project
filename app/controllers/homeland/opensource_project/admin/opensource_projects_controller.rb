module Homeland::OpensourceProject::Admin
  class OpensourceProjectsController < ::Admin::ApplicationController
    layout '/layouts/admin'

    def index
      @opensource_projects = OpensourceProject.includes(:user).order("id desc").page(params[:page])
    end

    def destroy
      @opensource_project = OpensourceProject.find_by_slug!(params[:id])
      @opensource_project.destroy
      redirect_to admin_opensource_projects_path
    end
  end
end
