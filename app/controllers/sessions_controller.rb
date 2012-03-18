class SessionsController < ApplicationController

  def new
  end

  def create
    auth_hash = env["omniauth.auth"]
    current_user_id = session[:user_id]

    if current_user_id
      # User has already signed in - add another provider
      User.find(current_user_id).add_provider_from_oauth_hash(auth_hash)
    else
      # Need to log in/sign up user
      auth = Authorization.find_or_create_from_oauth_hash(auth_hash)
      session[:user_id] = auth.user.id
    end

    redirect_to :root, :info => "Successfully logged in!"
  end

  def failure
    redirect_to :root, :alert => "Failed to log in - Check your Permissions"
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, :info => "Successfully logged out!"
  end

end
