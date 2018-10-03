class CommentsController < ApplicationController
	before_action :find_article, only: [:create, :destroy]
  def index
  end

  def create
  	@comment = @article.comments.new(comment_params)
  	@comment.user = current_user
  	if @comment.save
  		flash[:success] = "Thanks for commenting!"
  		redirect_to article_path(@article)
  	else
  		flash[:danger] = "sorry try again."
  		render json: { errors: @comment.errors }
  	end
  end

  def destroy
  	@comment = @article.comments.find(params[:id]) 
  	
  	if @comment.user == current_user || current_user.admin?
  	   @comment.destroy
  		flash[:success] = "Comment successfully destroyed."
  		redirect_to article_path(@article)

  	else
  		flash[:danger] = "Only allowed to delete your own comments"
  		redirect_to article_path(@article)
  	end
  end

  private 

  def comment_params
  	params.require(:comment).permit(:content)
  end

  def find_article 
  	@article = Article.find_by_id(params[:article_id]) if params[:article_id]
  end
end
