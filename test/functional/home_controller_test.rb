require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  context "Visiting the site as a user" do

    should "GET index" do
      get :index
      assert :success
    end

    should "GET about" do
      get :about
      assert :success
    end

    should "GET legal" do
      get :legal
      assert :success
    end

  end
end
