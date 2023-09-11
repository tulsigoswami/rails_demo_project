class RecipeSerializer < ActiveModel::Serializer
  attributes :title,:description ,:ingredients,:likes, :comments
  belongs_to :user
  has_many :likes
  has_many :comments

  def likes
    @object.likes.count
  end

  def comments
    @object.comments.pluck(:user_id,:text)
  end

end
