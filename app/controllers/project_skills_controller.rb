class ProjectSkillsController < ApplicationController
  def new
  end

  def create
    @project_skill = ProjectSkill.new(project_skills_params)

    if @project_skill.save
      redirect_to posts_path, status: :see_other
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end

  def project_skills_params
    params.require(:project_skills).permit(:project_id, skill_ids: [])
  end

end
