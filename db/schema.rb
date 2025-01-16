# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_16_184125) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baskets", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_baskets_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.integer "calories_unit"
    t.integer "protein_unit"
    t.integer "fat_unit"
    t.integer "carbs_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "category", default: [], array: true
  end

  create_table "ingredients_recipes", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "recipe_id", null: false
    t.decimal "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_ingredients_recipes_on_ingredient_id"
    t.index ["recipe_id"], name: "index_ingredients_recipes_on_recipe_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "basket_id", null: false
    t.bigint "ingredient_id", null: false
    t.boolean "bought"
    t.decimal "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "meal_refs", default: [], array: true
    t.index ["basket_id"], name: "index_items_on_basket_id"
    t.index ["ingredient_id"], name: "index_items_on_ingredient_id"
  end

  create_table "meals", force: :cascade do |t|
    t.date "date"
    t.bigint "basket_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_meals_on_basket_id"
    t.index ["recipe_id"], name: "index_meals_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "steps"
    t.integer "baseline_id"
    t.text "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "category", default: [], array: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "guest_token"
    t.boolean "is_guest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "baskets", "users"
  add_foreign_key "ingredients_recipes", "ingredients"
  add_foreign_key "ingredients_recipes", "recipes"
  add_foreign_key "items", "baskets"
  add_foreign_key "items", "ingredients"
  add_foreign_key "meals", "baskets"
  add_foreign_key "meals", "recipes"
end
