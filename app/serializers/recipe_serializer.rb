class RecipeSerializer < ActiveModel::Serializer
  attributes :title,:description,:ingredients
  has_many :likes
  has_many :comments
end
