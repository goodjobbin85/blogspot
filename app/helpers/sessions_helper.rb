module SessionsHelper

  def login(user)
  	session[:user_id] = user.id
  end

  def logout(user)
    session[:user_id] = nil
  end

  def logged_in?
  	!current_user.nil?
  end

  def require_logged_in
    if !logged_in?
      flash[:danger] = "Must be logged in."
      redirect_to users_path
    end
  end

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def show_session_requests 
   	"number of requests is #{session[:requests]}"
  end

end
