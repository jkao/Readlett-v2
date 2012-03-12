class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    session[:user_id].nil? ? nil : User.find(session[:user_id])
  end

end
