class User < ApplicationRecord
  has_many :posts

  validates_presence_of :email, :password
end
