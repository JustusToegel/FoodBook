class UsersController < ApplicationController
  # Create
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save

    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  # show Read One
  def show
    @user = User.find(params[:id])
    @cart_item = Cart.new
  end

  # update
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    redirect_to user_path(@user)
  end

  # delete
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :bio, :description, :instagram, :you_tube, :photo)
  end
end
