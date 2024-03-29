class MealsController < ApplicationController

  # Create
  def new
    @meal = Meal.new
    @ingredients = Ingredient.all
    if params[:query].present?
      @ingredients = @ingredients.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user_id = current_user.id
    @meal.save

    if @meal.save
      redirect_to new_user_meal_meal_ingredient_path(current_user, @meal)
    else
      render :new
    end
  end

  # show Read One
  def show
    @meal = Meal.find(params[:id])
    @cart_item = Cart.new
  end

  # update
  def edit
    @meal = Meal.find(params[:id])

    @ingredients = Ingredient.all
    if params[:query].present?
      @ingredients = @ingredients.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.update(meal_params)

    redirect_to meal_path(@meal)
  end

  # delete
  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to user_path(@meal.user), status: :see_other
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :instructions, :category, :servings, :photo, :prep_time)
  end
end
