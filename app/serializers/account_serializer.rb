class AccountSerializer < ActiveModel::Serializer
  attributes :id, :category,:ratings, :cc

  def category
    object.category.name
  end

  def ratings
   object.ratings.count
  end
end
