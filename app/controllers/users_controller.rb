class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :show, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @user = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successful signup! Welcome!"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "User changes successfully made!"
      redirect_to user_path
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @user.destroy
    flash[:danger] = "User and user's articles were successfully deleted!"
    redirect_to articles_path
  end
  
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only make changes to your own profile."
      redirect_to root_path
    end
  end

  
  private
  
  def find_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :user_name, :admin)
  end
  
end