class CategoriesController < ApplicationController
  before_action :find_cat, only: [:edit, :show, :update, :destroy]
  before_action :require_admin

  def index
    @category = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(cat_params)
    if @category.save
      flash[:success] = "Category was successfully created!"
      redirect_to category_path(@category)
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @category.update(cat_params)
      flash[:success] = "Category changes successfully made!"
      redirect_to category_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @category.destroy
    flash[:danger] = "User and user's articles were successfully deleted!"
    redirect_to articles_path
  end
  
  def require_admin
    if !current_user.admin?
      flash[:danger] = "You can only make changes to your own profile."
      redirect_to root_path
    end
  end
  
  private

  def find_cat
    @category = Category.find(params[:id])
  end
  
  def cat_params
    params.require(:category).permit(:category_name, :description)
  end

end
