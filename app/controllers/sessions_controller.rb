class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		login(user)
  		flash[:success] = "Logged in as #{current_user.name}."
  		redirect_to user_path(user)
  	else
  		flash[:danger] = "Invalid credentials"
  		render :new
  	end
  end

  def destroy
    flash[:success] = "#{ current_user.name } has logged out."
  	session[:user_id] = nil
  	redirect_to root_path
  end
end
