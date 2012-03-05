class SessionsController < ApplicationController

  def create
    auth_hash = env["omniauth.auth"]
    render :text => auth_hash.inspect
  end

  def failure
    redirect_to :root
  end

  def destroy
  end

end
