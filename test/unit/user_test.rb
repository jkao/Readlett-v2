require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "A user" do
    setup do
      @user = FactoryGirl.create(:user)
      @bookmark = FactoryGirl.create(:bookmark)
    end

    should "show up for like" do
      @bookmark.like!(@user)
      assert @user.likes?(@bookmark)

      @bookmark.unlike!(@user)
      assert_false @user.likes?(@bookmark)
    end

    should "show for follow" do
      @bookmark.follow!(@user)
      assert @user.follows?(@bookmark)

      @bookmark.unfollow!(@user)
      assert_false @user.follows?(@bookmark)
    end

    should "be able to get the latest bookmark entry" do
      new_url = "http://new-url.com"

      assert_false @user.follows?(@bookmark)
      assert_nil @user.current_bookmark_user_entry(@bookmark)

      @bookmark.follow!(@user)
      assert_equal @bookmark, @user.current_bookmark_user_entry(@bookmark).bookmark
      assert_equal @bookmark.url, @user.current_url(@bookmark)

      @user.update_bookmark_position(@bookmark, new_url)
      assert_equal @user.current_url(@bookmark), new_url
    end
  end
end
