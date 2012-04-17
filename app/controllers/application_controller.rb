class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?, :nsfw?

  protected

  def current_user
    session[:user_id].nil? ? nil : User.find(session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def nsfw?
    current_user && current_user.nsfw
  end

  def auth_check
    if current_user.nil?
      redirect_to login_path
    end
  end
end
