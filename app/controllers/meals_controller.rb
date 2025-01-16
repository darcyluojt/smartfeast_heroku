class MealsController < ApplicationController
  # skip_before_action :authenticate_user!
  def create
    # If user is logged in, use current_user, else create a guest user
    if current_user
      @user = current_user
    else
      @user = User.create_guest_user
      sign_in(@user)
    end
    # If user has a basket, use the last basket, else create a new basket
    if @user.baskets.present?
      @basket = Basket.where(user: @user).last
    else
      @basket = Basket.create!(user: @user, name: "Basket for #{@user.email}")
    end
    # Receive the recipe_id and date from the react UI component
    @meal = Meal.new(meal_params)
    @meal.basket = @basket
    basket_items = @meal.recipe.ingredients_recipes
    if @meal.save
      # Create items in the basket for each ingredient in the recipe
      basket_items.each do |recipe_ingredient|
        exist = @basket.items.find_by(ingredient: recipe_ingredient.ingredient)
        if exist
          exist.meal_refs << @meal.id
          exist.quantity += recipe_ingredient.quantity
          exist.save
        else
          @basket.items.create(ingredient: recipe_ingredient.ingredient, quantity: recipe_ingredient.quantity, unit: recipe_ingredient.unit, meal_refs: [@meal.id])
        end
      end
      respond_to do |format|
        format.html {
          flash[:notice] = 'Meal was successfully created.'
          redirect_to basket_path(@basket)
        }
        format.json {
          render json: {
          status: 'created',
          basket_url: basket_path(@basket),
          basket_id: @basket.id,
          flash: {
            notice: 'Meal was successfully created.'
          }
        }}
      end
    else
      render json: @meal.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy
    Item.remove_meal_refs(@meal.id)
    redirect_to basket_path(@meal.basket)
  end

  private

  def meal_params
    params.require(:meal).permit(:recipe_id, :date)
  end

end
