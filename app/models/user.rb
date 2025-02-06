class User < ApplicationRecord
  has_many :projects
  has_many :companies

  # user-skillの関連を定義
  has_many :user_skills, foreign_key: :user_id
  has_many :skills, through: :user_skills
  
  has_many :posts

  attr_accessor :remember_token

  validates :name,    presence: true, length: {maximum: 11}

  VALUD_EMAIN_REGEX = /\A@\w+\z/
  validates :user_id, presence: true, length: {maximum: 11},
                      format: {with: VALUD_EMAIN_REGEX},
                      uniqueness: true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
      SecureRandom.urlsafe_base64
  end

  def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
      remember_digest
  end

  def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
      update_attribute(:remember_digest, nil)
  end

  def session_token
      remember_digest || remember
  end

end
