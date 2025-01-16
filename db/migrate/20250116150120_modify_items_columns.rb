class ModifyItemsColumns < ActiveRecord::Migration[7.2]
  def change
    remove_column :items, :bought_time
    remove_column :items, :meal_refs  # First remove the existing column
    add_column :items, :meal_refs, :integer, array: true, default: []
    remove_column :recipes, :user_id
    remove_column :recipes, :category
    add_column :recipes, :category, :integer, array: true, default: []
    remove_column :ingredients, :category
    add_column :ingredients, :category, :integer, array: true, default: []
  end
end
