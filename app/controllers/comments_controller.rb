class CommentsController < ApiController
  before_action :authorize_request
  before_action :find_recipe
  before_action :authorize_user

  def create
    return unless @recipe

    @recipe.comments.create(user_id: @current_user.id, recipe_id: @recipe.id, text: params[:text])
    redirect_to recipe_path(@recipe)
  end

  def delete
    if !comment_exists?
      render plain: "You can't delete"
    else
      @comment = Comment.where(user_id: @current_user.id, recipe_id:
      params[:id], id: params[:comment_id]).first
      if @comment
        @comment.destroy
        render plain: 'comment deleted'
      end
    end
  end

  def update
    if !comment_exists?
      render plain: "You can't edit"
    else
      @comment = Comment.where(user_id: @current_user.id, recipe_id:
      params[:id], id: params[:comment_id]).first
      @comment.update(text: params[:text])
      render json: @comment
    end
  end

  private

  def comment_exists?
    Comment.where(user_id: @current_user.id, recipe_id:
    params[:id]).exists?
  end
end
