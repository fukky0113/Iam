class Project < ApplicationRecord
  belongs_to :user
  belongs_to :company

  # project-skillの関連を定義
  has_many :project_skills, foreign_key: :project_id
  has_many :skills, through: :project_skills

  def save_skills(project_id, skill_ids)
    skill_ids.each do |skill_id|
      if !(skill_id.blank?)
        Rails.logger.debug "project_id #{project_id} skill_id #{skill_id}"
        ProjectSkill.relation_create(project_id, skill_id)
      end
    end
  end
end
