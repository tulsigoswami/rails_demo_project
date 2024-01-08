class LikesController < ApiController
  before_action :authorize_request
  before_action :find_recipe
  before_action :authorize_user

  def create
    if already_liked?
      render plain: "You can't like more than once"
    else
      @recipe.likes.create(user_id: @current_user.id, recipe_id: @recipe.id)
      # @recipe.likes.create.update(count: @recipe.likes.count + 1)
      redirect_to recipe_path(@recipe)
    end
  end

  def dislike
    if !already_liked?
      render plain: "You can't unlike"
    else
      @like = Like.where(user_id: @current_user.id, recipe_id:
      params[:id]).first
      @like.destroy
      render plain: 'disliked recipe'
    end
  end

  private

  def already_liked?
    Like.where(user_id: @current_user.id, recipe_id:
    params[:id]).exists?
  end
end
