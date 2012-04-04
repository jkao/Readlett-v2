require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "a generic user" do
    setup do
      @user = FactoryGirl.create(:user)
    end

    should "show the user" do
      get :show, :id => @user.id
      # TODO: Assert sets
    end

    should "show self" do
      get :me
      # TODO: Logged in helper
    end
  end
end
