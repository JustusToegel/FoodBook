class MealIngredientsController < ApplicationController

  def new
    @meal_ingredient = MealIngredient.new
    @meal = Meal.find(params[:meal_id])
    @list = @meal.ingredients

    @ingredients = Ingredient.all
    if params[:query].present?
      @ingredients = @ingredients.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def create

    @meal = Meal.find(params[:meal_id])
    params.require(:meal_ingredient).permit(:ingredient_id)
    @meal_ingredient = MealIngredient.new(ingredient_id: params[:meal_ingredient][:ingredient_id])
    @meal_ingredient.meal = @meal
    @meal_ingredient.quantity = 1
    @meal_ingredient.save

    if @meal_ingredient.save
      redirect_to new_user_meal_meal_ingredient_path(current_user, @meal)
    else
      render :new
    end
  end

  def destroy
    @meal_ingredient = MealIngredient.find(params[:id])
    @meal_ingredient.destroy

    redirect_to new_user_meal_meal_ingredient_path(current_user, @meal_ingredient.meal), status: :see_other
  end
end
