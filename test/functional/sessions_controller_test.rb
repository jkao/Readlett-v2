require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  context "not logged in" do
    context "with valid omniauth token" do
      setup do
        @name = Faker::Name.name
        @email = Faker::Internet.email

        @omniauth_hash = {
          :provider => "facebook",
          :uid => UUID.generate(:compact),
          :info => {
            :name => @name,
            :email => @email
          }
        }
        @controller.expects(:omniauth_environment).returns(@omniauth_hash)
      end

      should "create a new user and authorization" do
        get :create
        assert_redirected_to root_path

        user = User.where(:name => @name, :email => @email).first
        assert_not_nil user
      end

      should "log user in if authorization exists" do
        existing_user = FactoryGirl.create(:user, :name => @name, :email => @email)
        existing_user_auth = FactoryGirl.create(:authorization,
                                                 :provider => @omniauth_hash[:provider],
                                                 :uid => @omniauth_hash[:uid],
                                                 :user => existing_user)

        get :create

        assert_redirected_to root_path
        assert_equal existing_user.id, session[:user_id]
      end
    end

    should "GET new" do
      get :new
      assert_response :success
    end

    should "GET destroy" do
      get :destroy
      assert_redirected_to root_path
    end

    should "GET failure" do
      get :failure
      assert_redirected_to root_path
    end
  end

  context "logged in" do
    setup do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    should "GET destroy" do
      get :destroy
      assert_redirected_to root_path
      assert_nil session[:user_id]
    end

    context "with an existing valid omniauth token" do
      setup do
        @name = Faker::Name.name
        @email = Faker::Internet.email

        @omniauth_hash = {
          :provider => "google",
          :uid => UUID.generate(:compact),
          :info => {
            :name => @name,
            :email => @email
          }
        }
        @controller.expects(:omniauth_environment).returns(@omniauth_hash)
      end

      should "add a provider" do
        get :create
        assert_redirected_to root_path
        assert_match "Added Authorization", flash[:success]
      end
    end
  end
end
