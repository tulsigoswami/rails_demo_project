class LikesController < ApplicationController
  before_action :authorize_request
  before_action :find_recipe

  def create
    if already_liked?
       render plain:"You can't like more than once"
    else
       @recipe.likes.create(user_id:@current_user.id,recipe_id:@recipe.id)
       redirect_to recipe_path(@recipe)
    end
  end

  def dislike
    @like = Like.where(user_id:@current_user.id, recipe_id:
    params[:id])
    if @like
      Like.destroy(@like.pluck(:id))
      redirect_to recipe_path(@recipe)
    else
      render plain:'you can not unlike'
    end
  end

  private
  def find_recipe
    @recipe = Recipe.find_by(id:params[:id])
  end

  def already_liked?
     Like.where(user_id:@current_user.id, recipe_id:
     params[:id]).exists?
  end
end
