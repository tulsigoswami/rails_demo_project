class User < ApplicationRecord
  has_secure_password
  has_one_attached :profile_image
  has_many :recipes
  has_many :likes
  has_many :comments

  validates :name,format: { with: /\A[\w-]+\z/, message: "your format requirements" }, presence: true
  validates :email,format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message:'invalid email'},presence: true, uniqueness: true
  validates :type, presence: true

  validates :password,  confirmation: true,length: {within: 8..20}

end
