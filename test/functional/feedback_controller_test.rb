require 'test_helper'

class FeedbackControllerTest < ActionController::TestCase
  context "not logged in" do

    should "POST feedback with message param" do
      message = "#{UUID.generate}"

      # Send the POST Request
      post :create, :message => message
      assert_response :success

      # Make sure the Feedback is Created
      assert_not_nil Feedback.where(:message => message).first
    end

    should "not POST feedback with message param" do
      # Send the POST Request
      post :create
      assert_response :bad_request
    end

  end

  context "logged in" do
    setup do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user
    end

    should "POST feedback with message param" do
      message = "#{UUID.generate}"

      # Send the POST Request
      post :create, :message => message
      assert_response :success

      # Make sure the Feedback is Created
      assert_not_nil Feedback.where(:message => message, :user_id => @user.id).first
    end

    should "not POST feedback with message param" do
      # Send the POST Request
      post :create
      assert_response :bad_request
    end
  end
end
