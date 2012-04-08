require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "a generic user" do
    setup do
      @user = FactoryGirl.create(:user)
    end

    should "show the user" do
      # TODO
    end

    should "show self" do
      # TODO
    end
  end
end
