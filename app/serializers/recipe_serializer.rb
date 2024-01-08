class RecipeSerializer < ActiveModel::Serializer
  attributes :title, :description, :ingredients#, :likes, :comments, :recipe_content
  # belongs_to :user
  # has_many :likes
  # has_many :comments

  # def likes
  #   @object.likes.count
  # end

  # def comments
  #   @object.comments.pluck(:user_id, :text)
  # end

  # def recipe_content
  #   Rails.application.routes.url_helpers.rails_blob_url(object.content, only_path: true) if object.content.attached?
  # end
end
