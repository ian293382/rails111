class Group < ApplicationRecord
  validates :title, presence: true

  has_many :user
end
