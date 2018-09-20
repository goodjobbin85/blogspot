class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def show 
		@article = Article.find(params[:id])
		@article_user = @article.user
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

	def edit 
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		@user = @article.user
		@article.update(article_params)
		if @article.save
			flash[:success] = "Article successfully updated!"
			redirect_to user_path(@user)
		else
			render :edit 
		end
	end

	def destroy 
		@article = Article.find(params[:id])
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
	
end
