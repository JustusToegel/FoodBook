# THIS IS THE USER CONTROLLER
class PagesController < ApplicationController
  def home
    @users = User.all
    if params[:query].present?
      @users = @users.where("name ILIKE ?", "%#{params[:query]}%")
    end
  end
end
