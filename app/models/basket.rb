class Basket < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :meals, dependent: :destroy
end
