class Project < ApplicationRecord
  belongs_to :user
  belongs_to :company

  # project-skillの関連を定義
  has_many :project_skills, foreign_key: :project_id
  has_many :skills, through: :project_skills
end
