class RecipesController < ApplicationController
  # skip_before_action :authenticate_user!
  def show
    @recipe = Recipe.find(params[:id])
    @steps = @recipe.steps.split("\r\n").reject(&:blank?)
  end

  def discover
    @first_recipe = Recipe.all.sample
    @props = {
      initialRecipe: @first_recipe.as_json(include: {
        ingredients_recipes: { include: :ingredient }}),
      nextUrl: random_recipes_path}
  end

  def random
    # @recipe = Recipe.where.not(id: current_user.viewed_recipes.pluck(:id)).sample
    next_recipe = Recipe.all.sample
    render json: next_recipe.as_json(include: {
    ingredients_recipes: { include: :ingredient }
  })
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :steps, :baseline_id, :user_id, :thumbnail, :category)
  end
end
