class RecipesController < ApiController
  # before_action :authorize_admin, only: [:index]
  before_action :authorize_request

  def index
    @recipes = Recipe.order(:title)
    render json: @recipes
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      @recipe.content.attach(params[:content])
      render json: @recipe
    else
      render json: @recipe.errors.full_messages
    end
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    return unless @recipe

    @recipe.update(recipe_params)
    render json: @recipe
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    return unless @recipe

    render json: @recipe
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    return unless @recipe.destroy

    render plain: 'Recipe deleted successfully'
  end

  private

  def recipe_params
    params.permit(:title, :user_id, :description, :ingredients, :content)
  end
end
