class User < ApplicationRecord
    validates :name,    presence: true, length: {maximum: 11}

    VALUD_EMAIN_REGEX = /@[a-z]+/
    validates :user_id, presence: true, length: {maximum: 11},
                        format: {with: VALUD_EMAIN_REGEX},
                        uniqueness: true

    has_secure_password
    validates :password, presence: true, length: {minimum: 6}

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
