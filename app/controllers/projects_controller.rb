class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy, :edit, :update]
  before_action :admin_user, only: [:new, :create, :destroy, :edit, :update]

  def new
    @project = Project.new
    @project_skill = ProjectSkill.new
    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def create
    @project = Project.new(project_params)
    # ポスト可能ユーザーを限定
    @project.user_id = User.first.id

    if @project.save
      skill_ids = project_skill_params[:project_skill]
      if @project.save_skills(@project.id, skill_ids[:skill_id])
        redirect_to posts_path, status: :see_other
      else
        render 'new', status: :unprocessable_entity
      end
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to posts_path, status: :see_other
  end

  def edit
    @project = Project.find(params[:id])
    @project_skill = ProjectSkill.new
    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def update
    @project = Project.find(params[:id])
    # ポスト可能ユーザーを限定
    @user = User.first

    update_flg = false
    if @project.update(project_params)
      skill_ids = project_skill_params[:project_skill]
      if @project.update_skills(@project.id, skill_ids[:skill_id])
        redirect_to posts_path, status: :see_other
        update_flg = true
      end
    end

    render 'edit', status: :unprocessable_entity unless update_flg
  end

  private

  def project_params
    params.require(:project).permit(:summary, :incharge, :achivement, :user_id, :company_id, :start_on, :end_on)
  end

  def project_skill_params
    params.require(:project).permit(project_skill: [skill_id: []])
  end
end
