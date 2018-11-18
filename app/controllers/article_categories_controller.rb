class ArticleCategoriesController < ApplicationController
  
  def index
    @category = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
end

