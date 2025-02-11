class Post < ApplicationRecord
  has_rich_text :content
  belongs_to :category
  belongs_to :user

  validates :title, presence: true
end
