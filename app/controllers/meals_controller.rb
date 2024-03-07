class MealsController < ApplicationController

  # Create
  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user_id = current_user.id
    @meal.save

    if @meal.save
      redirect_to meal_path(@meal)
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
  end

  def update
    @meal = Meal.find(params[:id])
    @meal.update(meal_params)

    redirect_to user_meal_path(@meal)
  end

  # delete
  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to user_path(@meal.user), status: :see_other
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :instructions, :photo, :prep_time)
  end
end
