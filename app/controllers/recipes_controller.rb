class RecipesController < ApplicationController
   before_action :authorize_admin, only: [:index]
   before_action :authorize_request

  def index
    @recipes= Recipe.all
    render json: @recipes
  end

  def create
    @recipe = Recipe.new(recipe_params)
    # byebug
    if @recipe.save
     @recipe.content.attach(params[:content])
     RecipeMailer.with(recipe:@recipe).post_notify.deliver_now
     render json: @recipe
    else
     render json: @recipe.errors.full_messages
    end
  end

  def update
    @recipe = Recipe.find_by(id:params[:id])
    if @recipe
    @recipe.update(recipe_params)
    render json: @recipe
    end
  end

  def show
   @recipe = Recipe.find_by(id:params[:id])
   if @recipe
    render json: @recipe
   end
  end

  def destroy
   @recipe = Recipe.find(params[:id])
   if @recipe.destroy
    render plain: "recipe deleted successfully"
   end
  end

  private
  def recipe_params
    params.permit(:user_id,:title,:description,:ingredients,:content)
  end

  def authenticate_user

  end
end
