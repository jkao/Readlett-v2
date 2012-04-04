class SessionsController < ApplicationController

  def new
  end

  def create
    auth_hash = env["omniauth.auth"]
    current_user_id = session[:user_id]

    # Create a User or Add a Provider to Existing One
    # TODO: create or add seems to violate single-responsibility
    if signed_in?
    else
    end

    session[:user_id] = User.create_or_add_provider(auth_hash, current_user_id)

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
