class Group < ApplicationRecord
  validates :title, presence: true

  has_many :groups
end
