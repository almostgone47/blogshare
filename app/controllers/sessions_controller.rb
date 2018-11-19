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

  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = edit_user_path(user)
    end
    session[:user_id] = user.id
    redirect_to @next
  end

end
