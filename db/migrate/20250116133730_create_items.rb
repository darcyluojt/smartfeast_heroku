class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :basket, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.boolean :bought
      t.decimal :quantity
      t.time :bought_time
      t.string :unit
      t.integer :meal_refs

      t.timestamps
    end
  end
end
