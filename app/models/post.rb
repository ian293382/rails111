class Post < ApplicationRecord

  validates :title, presence: true

  belongs_to :user
  belongs_to :group

  scope :recent, -> { order("created_at DESC")}
end
