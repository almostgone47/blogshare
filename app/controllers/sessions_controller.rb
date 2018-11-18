class SessionsController < ApplicationController

  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You've successfully logged in."
      redirect_to root_path
    else
      flash.now[:danger] = "There was a problem with your log in. Please try again."
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end

end
