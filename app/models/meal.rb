class Meal < ApplicationRecord
  belongs_to :basket
  belongs_to :recipe
  has_many :items, through: :basket
end
