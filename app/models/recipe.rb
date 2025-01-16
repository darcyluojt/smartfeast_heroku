class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :ingredients_recipes, dependent: :destroy
  has_many :ingredients, through: :ingredients_recipes
  has_many :meals, dependent: :destroy

  validates :name, presence: true, uniqueness: true

end
