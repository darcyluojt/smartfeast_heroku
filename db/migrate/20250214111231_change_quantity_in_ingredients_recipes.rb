class ChangeQuantityInIngredientsRecipes < ActiveRecord::Migration[7.2]
  def change
    remove_column :ingredients_recipes, :quantity
    add_column :ingredients_recipes, :quantity, :text
    add_column :recipes, :servings, :integer
    add_column :recipes, :calories, :integer
    add_column :recipes, :protein, :integer
  end
end
