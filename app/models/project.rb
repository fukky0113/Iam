class Project < ApplicationRecord
  belongs_to :user
  belongs_to :company

  # project-skillの関連を定義
  has_many :project_skills, foreign_key: :project_id
  has_many :skills, through: :project_skills

  validates :summary, presence: true
  validates :incharge, presence: true
  validates :achivement, presence: true
  validates :start_on, presence: true
  validates :end_on, presence: true

  # post-indexにて呼び出されprojectモデルの変更を行う
  def save_skills(project_id, skill_ids)
    skill_ids.each do |skill_id|
      ProjectSkill.relation_create(project_id, skill_id) unless skill_id.blank?
    end
  end

  # 実質的なupdate(そのプロジェクトIDを全て削除→要求のスキルIDを登録)。
  def update_skills(project_id, skill_ids)
    projectskills = ProjectSkill.where(project_id: project_id)

    projectskills.each do |project_skill|
      ProjectSkill.relation_destroy(project_skill)
    end

    skill_ids.each do |skill_id|
      ProjectSkill.relation_create(project_id, skill_id) unless skill_id.blank?
    end
  end
end
