class BasketsController < ApplicationController
  def index
    if current_user.present? && current_user.baskets.present?
      redirect_to basket_path(current_user.baskets.last)
    end
  end

  def show
    @basket = Basket.find(params[:id])
    @meals = @basket.meals
    @basket_items = @basket.items
  end
end
