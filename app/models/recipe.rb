class Recipe < ApplicationRecord
  has_one_attached :content
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, presence: true
end
