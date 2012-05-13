class SessionsController < ApplicationController

  def new
  end

  def create
    omniauth = omniauth_environment
    authorization = Authorization.find_by_provider_and_uid(omniauth[:provider], omniauth[:uid])

    if authorization
      session[:user_id] = authorization.user.id
      flash[:success] = "Signed in Successfully!"
    elsif signed_in?
      current_user.authorizations.create({
        :provider => omniauth[:provider],
        :uid => omniauth[:uid]
      })
      flash[:success] = "Added Authorization Successfully!"
    else
      user = User.new({
        :name => omniauth[:info][:name],
        :email => omniauth[:info][:email]
      })
      user.authorizations.build({
        :provider => omniauth[:provider],
        :uid => omniauth[:uid]
      })
      user.save!

      session[:user_id] = user.id
      flash[:success] = "Welcome to Mediac!"
    end

    redirect_to :root
  end

  def failure
    redirect_to :root, :alert => "Failed to log in - Check your Permissions"
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, :info => "Successfully logged out!"
  end

  private

  # This wraps around the Rack environment and makes it easier to mock
  def omniauth_environment
    env["omniauth.auth"]
  end

end
