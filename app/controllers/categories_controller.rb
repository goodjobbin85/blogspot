class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]
  def index
    @categories = Category.all
  end

  def show
    @category_articles = @category.articles
  end

  def new
    @category = Category.new
  end

  def create 
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category Successfully saved!"
      redirect_to categories_path
    else
      flash[:notice] = "A problem has occurred. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category successfully edited."
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = "Category: '#{@category.name}' successfully removed."
      redirect_to categories_path
    else
      redirect_to categories_path
    end
  end

  private 

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  private 

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Must be admin to perform this task."
      redirect_to categories_path
    end
  end

  
end
