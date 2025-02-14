class DeleteUnitFromIngredientsRecipes < ActiveRecord::Migration[7.2]
  def change
    remove_column :ingredients_recipes, :unit
  end
end
