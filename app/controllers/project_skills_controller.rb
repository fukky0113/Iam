class ProjectSkillsController < ApplicationController
  def new
  end

  def create
    @project_skill = ProjectSkill.new(project_skills_params)

    if @project_skill.save
      render 'projects/new', status: :see_other
    else
      render 'projects/new', status: :unprocessable_entity
    end
  end

  def destroy
  end

  def project_skills_params
    params.require(:project_skill).permit(:skill_ids)
  end

end
