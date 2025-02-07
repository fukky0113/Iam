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

    if @project.save!
      skill_ids = project_skill_params[:project_skill]
      if @project.save_skills(@project.id, skill_ids[:skill_id])
        redirect_to posts_path, status: :see_other
      else
        render 'project/new', status: :unprocessable_entity
      end
      # Rails.logger.debug "hello #{skill_ids[:skill_id]}"

      # skill_ids[:skill_id].each do |skill_id|
      #   Rails.logger.debug "hello #{skill_id}"

      #   @project_skill = ProjectSkill.new
      #   @project_skill.project_id = @project.id
      #   @project_skill.skill_id = skill_id

        # unless @project_skill.save
        #   render 'new', status: :unprocessable_entity
        # end  
      # end
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to posts_path, status: :see_other
  end

  def edit
    @project = Project.find(params[:id])

    # ポスト可能ユーザーを限定
    @user = User.first
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      redirect_to posts_path, status: :see_other
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:summary, :incharge, :achivement, :user_id, :company_id, project_skill_attribute: {project_skill:[skill_id:[]]})
    # params.require(:project).permit(project_skill:[skill_id:[]])
  end

  def project_skill_params
    params.require(:project).permit(project_skill:[skill_id:[]])
  end

end
