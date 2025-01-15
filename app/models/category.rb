class Category < ApplicationRecord
  has_many :posts

  validates :category, presence: true, uniqueness: true
end
