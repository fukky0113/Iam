class Company < ApplicationRecord
  belongs_to :user

  has_many :projects

  validates :company_name, presence: true, uniqueness: true
end
