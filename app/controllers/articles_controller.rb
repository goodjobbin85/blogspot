class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def show 
		@article = Article.find(params[:id])
	end

	def create
		@user = User.find(params[:user_id])
		@article = @user.articles.create(article_params)
		if @article.save
			flash[:success] = "Article successfully created!"
			redirect_to user_path(@user)
		else
			flash[:danger] = "Please provide correct parameters."
			redirect_to user_path(@user)
		end
	end

	def destroy 
		@user = User.find(params[:user_id])
		@article = @user.articles.find(params[:id])
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
	
end
