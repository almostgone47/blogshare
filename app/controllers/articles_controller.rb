class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :show, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  
  def index
    @article = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def edit
  end
  
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully edited!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted!"
    redirect_to articles_path
  end
  
  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:danger] = "You can only make changes to your own articles."
      redirect_to root_path
    end
  end

  
  private
  
  def find_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end
end