class Recipe < ApplicationRecord

  has_one_attached :content
  belongs_to :user
  has_many :likes
  has_many :comments

  validates :title,:description,presence: true
end
