class Item < ApplicationRecord
  belongs_to :basket
  belongs_to :ingredient
  validates :ingredient_id, uniqueness: { scope: :basket_id }

  def add_meal(meal_id)
    self.meal_refs << meal_id
  end

  def remove_meal(meal_id)
    self.meal_refs.delete(meal_id)
    if self.meal_refs.empty?
      self.destroy
    end
  end

  def self.remove_meal_refs(meal_id)
    Item.where('meal_refs @> ARRAY[?]::integer[]', meal_id).each do |item|
      item.remove_meal(meal_id)
    end
  end
end
