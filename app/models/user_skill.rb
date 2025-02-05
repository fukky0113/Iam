class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill

  # user_idとskill_idの組み合わせが一意であること
  validates :user_id, uniqueness: { scope: :skill_id }, presence: true
  validates :skill_id, presence: true
end
