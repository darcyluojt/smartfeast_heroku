class CreateIngredientsRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients_recipes do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.decimal :quantity
      t.string :unit

      t.timestamps
    end
  end
end
