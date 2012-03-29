class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @is_owner = current_user && current_user.id == params[:id}
  end

end
