class ProjectsController < ApplicationController
  def new
    @project = Project.new
    @project_skill = ProjectSkill.new
    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def create
    @project = Project.new(project_params)
    #ポスト可能ユーザーを限定
    @project.user_id = User.first.id

    if @project.save
      skill_ids = project_skill_params[:project_skill]
      if @project.save_skills(@project.id, skill_ids[:skill_id])
        redirect_to posts_path, status: :see_other
      else
        render 'new', status: :unprocessable_entity
      end
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

    if @project.update(project_params)
      skill_ids = project_skill_params[:project_skill]
      if @project.update_skills(@project.id, skill_ids[:skill_id])
        redirect_to posts_path, status: :see_other
      else
        render 'edit', status: :unprocessable_entity
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:summary, :incharge, :achivement, :user_id, :company_id, :start_on, :end_on)
  end

  def project_skill_params
    params.require(:project).permit(project_skill:[skill_id:[]])
  end

end
