class Meal < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :ingredients, through: :meal_ingredients
  validates :name, presence: true
  validates :instructions, presence: true
  validates :description, presence: true
end
