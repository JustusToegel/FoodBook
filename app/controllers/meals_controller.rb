class MealsController < ApplicationController
  def index
    @flats = Flat.all
    if params[:query].present?
      @flats = Flat.search_by_name_and_address(params[:query])
    end
  end

  # Create
  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user_id = current_user.id
    @flat.save

    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  # show Read One
  def show
    @flat = Flat.find(params[:id])
  end

  # update
  def edit
    @flat = Flat.find(params[:id])
  end

  def update
    @flat = Flat.find(params[:id])
    @flat.update(flat_params)

    redirect_to flat_path(@flat)
  end

  # delete
  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy

    redirect_to flats_path, status: :see_other
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :address, :price, :photo)
  end
end
