class UsersController < ApplicationController
  def show
  end

  def update
    @user = User.find_by id: params[:id]
    respond_to do |format|
    if params[:user] [:is_change_password] == "0"
      @user.assign_attributes user_info_params
      if @user.save
        format.js
      else
        format.js
      end
    elsif params[:user][:is_change_password] == "1" 
      if @user.authenticate(params[:user][:current_password])
        @user.assign_attributes user_pass_info_params
        if @user.save
          format.js
          #completed
        else
          format.js
          #invalid params
        end
      else
        format.js
        @user.valid?
        @isAuthMess ="Mật khẩu cũ không chính xác!"
        #authen wrong
      end
    end
    end
  end

  private
  def user_info_params
    params[:user].permit(:name, :phone_number, :is_change_password)
  end

  def user_pass_info_params
    params[:user].permit(:name, :phone_number, :password, :password_confirmation, :is_change_password)
  end
end
