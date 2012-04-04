require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "A user" do
    setup do
      @user = FactoryGirl.build(:user)
    end

    should "set e-mail address to lower case on save" do
      email = "TEST@TEST.COM"

      @user.email = email
      @user.save!

      assert_equal email.downcase, @user.email
    end

    should "be able to add an authentication provider to existing user" do
       # TODO
    end

    should "not add another authentication provider if it has one before" do
      # TODO
    end
  end

  context "With no existing user, with authorization hash" do
    setup do
      # TODO
    end

    should "be able to create a user from authorization hash" do
      # TODO
    end

    should "not create user with duplicate authorization hash" do
      # TODO
    end
  end
end
