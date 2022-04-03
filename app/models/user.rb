class User < ApplicationRecord
  has_many :groups
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


#串連關係 會有很多（使用者加入或未加入）群組的關係 ,透過 群組加入來判別
    has_many :group_relationships
    has_many :participated_groups, :through => :group_relationships, :source => :group


    def is_member_of?(group)
       participated_groups.include?(group)
    end
end
