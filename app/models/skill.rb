class Skill < ApplicationRecord
  has_many :user_skills, foreign_key: :skill_id
  has_many :users, through: :user_skills
end
