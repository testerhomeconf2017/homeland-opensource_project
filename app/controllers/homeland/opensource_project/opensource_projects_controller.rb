module Homeland::OpensourceProject
  class OpensourceProjectsController < Homeland::OpensourceProject::ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :update, :publish, :destroy]
    before_action :set_opensource_project, only: [:show, :edit, :update, :publish, :destroy]

    def index
      @opensource_projects = OpensourceProject.includes(:user).published.order('published_at desc, id desc').page(params[:page]).per(10)
    end

    def upcoming
      @opensource_projects = OpensourceProject.includes(:user).upcoming.order('id desc').page(params[:page]).per(10)
    end

    def show
      @opensource_project.hits.incr(1)
    end

    def preview
      out = Homeland::Markdown.call(params[:body])
      render plain: out
    end

    def new
      authorize! :create, OpensourceProject
      @opensource_project = OpensourceProject.new
    end

    def edit
      authorize! :update, @opensource_project
    end

    def create
      authorize! :create, OpensourceProject
      @opensource_project = OpensourceProject.new(opensource_project_params)
      @opensource_project.user_id = current_user.id

      if @opensource_project.save
        redirect_to @opensource_project, notice: '文章提交成功，需要等待管理员审核。'
      else
        render :new
      end
    end

    def update
      authorize! :update, @opensource_project
      if @opensource_project.update(post_params)
        redirect_to @opensource_project, notice: '文章更新成功。'
      else
        render :edit
      end
    end

    def publish
      authorize! :publish, @opensource_project
      @opensource_project.published!
      redirect_to opensource_projects_path, notice: "文章审核成功。"
    end

    def destroy
      authorize! :destroy, @opensource_project
      @opensource_project.destroy
      redirect_to opensource_projects_url, notice: '文章删除成功。'
    end

    private
      def set_opensource_project
        @opensource_project = OpensourceProject.find_by_slug!(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def opensource_project_params
        params.require(:opensource_project).permit(:title, :slug, :body, :summary)
      end
  end
end
