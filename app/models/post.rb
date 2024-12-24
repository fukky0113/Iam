class Post < ApplicationRecord
  has_rich_text :content

  validates :title,    presence: true, length: {maximum: 11}

end
