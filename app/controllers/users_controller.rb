class UsersController < ApplicationController
  def show
  end

  def update
  end

  private
  def user_info_params
    params[:user].permit(:name, :phone_number)
  end
end
