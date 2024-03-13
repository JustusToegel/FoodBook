class MealIngredientsController < ApplicationController

  def new
    @ingredients = Ingredient.all
    
  end

  def create
  end
end
