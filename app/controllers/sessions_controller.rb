class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  		login(user)
  		flash[:success] = "You are now logged in."
  		redirect_to user_path(user)
  	else
  		flash[:danger] = "Invalid credentials"
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	flash[:success] = "You logged out."
  	redirect_to root_path
  end
end
