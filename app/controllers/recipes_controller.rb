class RecipesController < ApplicationController
   before_action :authorize_admin, only: [:index]
   before_action :authorize_request

  def index
    @recipes= Recipe.all
    render json: @recipes
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
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
    params.permit(:title,:description,:ingredients)
  end

  def authenticate_user

  end
end
