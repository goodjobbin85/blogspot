class ArticlesController < ApplicationController
	before_action :set_article, except: [:index, :create]
	before_action :require_same_user, only: [:edit, :update]
	before_action :require_admin, only: [:destroy]

	def index
		@articles = Article.all
	end

	def show 
		@article_user = @article.user
	end

	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Article successfully created!"
			redirect_to user_path(current_user)
		else
			flash[:danger] = "Please provide correct parameters."
			redirect_to user_path(current_user)
		end
	end

	def edit 

	end

	def update
		@article.update(article_params)
		if @article.save
			flash[:success] = "Article successfully updated!"
			redirect_to user_path(current_user)
		else
			render :edit 
		end
	end

	def destroy 
		@user = @article.user
		if @article.destroy
			flash[:success] = "Article succesfully eliminated."
			redirect_to user_path(@user)
		else
			flash[:danger] = "An error occurred while attempting to delete article."
			redirect_to user_path(@user)
		end
	end

	private 

	def article_params
		params.require(:article).permit(:title, :description)
	end

	def set_article 
		@article = Article.find(params[:id])
	end

	def require_same_user 
	    if current_user != @article.user
	      flash[:danger] = "Must own this account to perform this action."
	      redirect_to users_path
	    end
	end

	def require_admin
	    if logged_in? and (!current_user.admin? && current_user != @user)
	      flash[:danger] = "Must be admin to perform this action."
	      redirect_to users_path
	    end
	end
	
end
