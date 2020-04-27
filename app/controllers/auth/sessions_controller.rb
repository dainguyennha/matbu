class Auth::SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
    
  end
  def new_page
    
  end
  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] = remember(user)
      redirect_back_or root_url
    else
      respond_to do |format|
        format.js
      end
    end    
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
