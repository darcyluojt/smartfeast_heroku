# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"

Recipe.destroy_all
Ingredient.destroy_all
Basket.destroy_all
User.destroy_all
# Profile.destroy_all

# id = ["53079", "52827", "52873", "52950","52945","52823","52820"]
id = ["52951", "52870", "52975", "52969","52947","53079", "52827", "52873", "52950","52945","52823","52820","52846","52828", "52948","53083","53073","52903"]

url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
id.each do |i|
  # parse the food database url for the exact recipe id
  full_url = url + i
  uri = URI.parse(full_url).read
  meals = JSON.parse(uri)["meals"][0]
  name = meals["strMeal"]
  puts "Creating #{name}"
  instructions = meals["strInstructions"]
  category = []
  category << meals["strCategory"]
  category << meals["strArea"]
  thumbnail = meals["strMealThumb"]
  new_recipe = Recipe.new(name: name, steps: instructions, category: category, thumbnail: thumbnail)
  new_recipe.save
  puts "Created #{name}"
  # create recipe ingredients. However, if no ingredients are found, then create the ingredient first with usda api call
  i = 1
  until meals["strIngredient#{i}"].nil?
    break if meals["strIngredient#{i}"].empty?
    ingredient_name = meals["strIngredient#{i}"]
    if Ingredient.find_by(name: ingredient_name)
      ingredient = Ingredient.find_by(name: ingredient_name)
    else
      # later on build a API call to get the calories and protein
      service = NrelService.new
      results = service.search_food(ingredient_name)
      puts "Searching for #{ingredient_name}"
      unless results["foods"].empty? || results["foods"].nil?
        nutrients = results["foods"][0]["foodNutrients"]
        protein = nutrients.find { |nutrient| nutrient["nutrientId"] == 1003 }
        protein = protein.nil? ? 0 : protein["value"]
        fat = nutrients.find { |nutrient| nutrient["nutrientId"] == 1004 }
        fat = fat.nil? ? 0 : fat["value"]
        carbs = nutrients.find { |nutrient| nutrient["nutrientId"] == 1005 }
        carbs = carbs.nil? ? 0 : carbs["value"]
        calories = nutrients.find { |nutrient| nutrient["nutrientId"] == 1008 }
        calories = calories.nil? ? 0 : calories["value"]
        ingredient = Ingredient.new(name: ingredient_name, calories_unit: calories, protein_unit: protein, fat_unit: fat, carbs_unit: carbs)
        ingredient.save
      else
        puts "No results found for #{ingredient_name}"
      end

    end
    quantity = meals["strMeasure#{i}"]
    unit = meals["strMeasure#{i}"].scan(/[a-zA-Z]+/).join
    new_ingredient_recipe = IngredientsRecipe.new(recipe: new_recipe, ingredient: ingredient, quantity: quantity, unit: unit)
    new_ingredient_recipe.save
    puts "Added #{ingredient_name} to #{name}"
    i += 1
  end
end

# User and profile functionality are not ready.
# puts "creating new user"
# new_user = User.create!(email: "123@123.com", password: "123456")


# puts "creating new profile"
# Profile.create!([
#   {
#     user_id: new_user.id,
#     nickname: "Darcy",
#     gender: "Femle",
#     yourself: true,
#     fitness_goal: "Gain lean muscle",
#     meal_plan: "High Protein",
#     meals_per_day: 4,
#     calories_per_day: 2800,
#     protein_per_day: 180,
#     carbs_per_day: 320,
#     date_of_birth: Date.new(1990, 1, 15),
#     height: 180,
#     weight: 80
#   },
#   {
#     user_id: new_user.id,
#     nickname: "Leo",
#     gender: "Male",
#     yourself: false,
#     fitness_goal: "Lose weight",
#     meal_plan: "Low Carbs",
#     meals_per_day: 5,
#     calories_per_day: 2200,
#     protein_per_day: 160,
#     carbs_per_day: 220,
#     date_of_birth: Date.new(1990, 1, 15),
#     height: 180,
#     weight: 80
#   }
# ])
