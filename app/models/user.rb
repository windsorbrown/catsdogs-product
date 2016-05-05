class User < ActiveRecord::Base
  has_many :photos
  has_many :votes

  validates :user_name , uniqueness: true
  validates :email , uniqueness:true


end