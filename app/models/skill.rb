class Skill < ApplicationRecord
  has_many :user_skills, foreign_key: :skill_id
  has_many :users, through: :user_skills

  # project-skillの関連を定義
  has_many :project_skills, foreign_key: :skill_id
  has_many :projects, through: :project_skills
end
