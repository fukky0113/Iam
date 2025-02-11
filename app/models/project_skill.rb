class ProjectSkill < ApplicationRecord
  belongs_to :project
  belongs_to :skill

  # user_idとskill_idの組み合わせが一意であること
  validates :project_id, uniqueness: { scope: :skill_id }, presence: true
  validates :skill_id, presence: true

  def self.relation_create(project_id, skill_id)
    ProjectSkill.create(project_id: project_id, skill_id: skill_id)
  end

  def self.relation_destroy(project_id)
    project_id.destroy
  end
end
