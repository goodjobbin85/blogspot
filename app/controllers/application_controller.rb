class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
   before_action :number_of_requests_in_session

   include SessionsHelper

   def number_of_requests_in_session 
   	session[:requests] ||= 0 
   	session[:requests] += 1
   end

   


end
