class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :steps
      t.integer :baseline_id
      t.references :user, null: false, foreign_key: true
      t.text :thumbnail
      t.text :category

      t.timestamps
    end
  end
end
