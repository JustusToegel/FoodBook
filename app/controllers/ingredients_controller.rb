class IngredientsController < ApplicationController
  def new
  end

  def create
    @ingredient = Ingredient.new(ing_params)
    @ingredient.save
  end

  def index
    @ingredients = Ingredient.all
  end

  private

  def ing_params
    params.require(:ingredient).permit(:name, :size, :price, :instruction_name)
  end
end
