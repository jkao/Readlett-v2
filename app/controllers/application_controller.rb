class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?

  def current_user
    session[:user_id].nil? ? nil : User.find(session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end
end
