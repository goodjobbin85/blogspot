class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_logged_in, only: [:destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = "User successfully saved."
      redirect_to users_path
    else
      flash[:danger] = "Please try again."
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = "User successfully updated."
      redirect_to user_path(@user)
    else
      flash[:danger] = "Try again, bad parameters."
      render :edit
    end
  end

  def destroy
    flash[:success] = "#{@user.name} successfuly deleted."
    @user.destroy
    if current_user == @user
      logout(@user)
    end
    redirect_to users_path
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def require_same_user 
    if current_user != @user
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
