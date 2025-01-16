class DeleteCategoryFromRecipe < ActiveRecord::Migration[7.2]
  def change
    remove_column :recipes, :category
    add_column :recipes, :category, :text, array: true, default: []
    remove_column :ingredients, :category
    add_column :ingredients, :category, :text, array: true, default: []
  end
end
