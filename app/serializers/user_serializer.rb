class UserSerializer < ActiveModel::Serializer
  attributes :name
  # has_one_attached :profile_image
  has_many :recipes
end
