class CartsController < ApplicationController

  def index
    @cart = current_user.carts
  end

  def create
    @cart_item = Cart.new
    if defined? params[:cart][:amount]
      params.require(:cart).permit(:amount)
      @cart_item.amount = params[:cart][:amount].to_i
    else
      @cart_item.amount = params[:amount].to_i
    end
    @cart_item.user = current_user
    @cart_item.meal_id = params[:meal_id].to_i
    @cart_item.save!


    if @cart_item.save
      # redirect_to user_path(@cart_item.meal.user)
      # redirect_to meal_path(@cart_item.meal)
      redirect_to user_path(@cart_item.meal.user)

    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    @cart_item = Cart.find(params[:id])
    @cart_item.destroy
    redirect_to carts_path, status: :see_other
  end

  def shoppinglist
    @cart = current_user.carts
  end

  private

  def cart_params
    params.require(:cart).permit(:amount)
  end
end
