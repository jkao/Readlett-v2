require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "a generic user" do
    setup do
      @user = FactoryGirl.create(:user)
    end

    should "GET show" do
      get :show, :id => @user.id
      assert_response :success
    end

    should "not GET me, instead REDIRECT" do
      get :me
      assert_redirected_to login_path
    end

    context "logged in" do
      setup do
        @request.session[:user_id] = @user.id
      end

      should "GET me" do
        get :me
        assert_response :success
        assert_equal @user, assigns(:user)
        assert_equal @user.current_bookmarks, assigns(:bookmarks)
      end
    end
  end
end
