class ProjectSkill < ApplicationRecord
  belongs_to :project
  belongs_to :skill

  def ProjectSkill.relation_create(project_id, skill_id)
    ProjectSkill.create(project_id: project_id, skill_id: skill_id)
  end
end
