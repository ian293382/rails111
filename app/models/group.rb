class Group < ApplicationRecord
  validates :title, presence: true
  has_many :posts
  belongs_to :user

  #會有很多會員 會有很多關係
 has_many :group_relationships
  has_many :members, through: :group_relationships, source: :user
end
