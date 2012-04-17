require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  context "logged in" do
    setup do
      @user = FactoryGirl.create(:user)
      @bookmark = FactoryGirl.create(:bookmark)
      @request.session[:user_id] = @user.id
    end

    should "GET index" do
      get :index
      assert_response :success
      assert assigns(:bookmarks).include?(@bookmark)
    end

    should "GET show" do
      get :show, :id => @bookmark.id
      assert_response :success
      assert_equal @bookmark, assigns(:bookmark)
    end

    should "GET redirect" do
      original_views = @bookmark.views

      get :redirect, :id => @bookmark.id
      assert_redirected_to @bookmark.url

      @bookmark.reload

      assert_equal (original_views + 1), @bookmark.views
    end

    should "GET popular" do
      get :popular
      assert_response :success
      assert assigns(:bookmarks).include?(@bookmark)
    end

    should "POST create" do
      attributes = FactoryGirl.attributes_for(:bookmark)

      post :create, :bookmark => attributes
      assert_response :success

      attributes.slice!(:title, :description, :private, :nsfw, :views, :likes_count)
      json_response = JSON.parse(@response.body)
      created_bookmark = Bookmark.find(json_response["id"])

      assert_not_nil created_bookmark

      attributes.each do |k, v|
        assert_equal v, json_response[k.to_s]
      end

      assert @user.follows?(created_bookmark)
    end

    should "POST update preventing mass-exploit" do
      old_views = @bookmark.views
      new_attributes = {
        :title => "new title",
        :description => "new description",
        :url => "http://test.com",
        :private => true,
        :nsfw => true,
        :views => 9000
      }

      put :update, :id => @bookmark.id, :bookmark => new_attributes
      assert_response :success

      @bookmark.reload

      assert_equal @bookmark.title, new_attributes[:title]
      assert_equal @bookmark.description, new_attributes[:description]
      assert_equal @bookmark.url, new_attributes[:url]
      assert_equal @bookmark.private, new_attributes[:private]
      assert_equal @bookmark.nsfw, new_attributes[:nsfw]
      assert_equal @bookmark.views, old_views
    end

    should "DELETE destroy" do
      user_bookmark = FactoryGirl.create(:bookmark, :user => @user)

      assert @user.bookmarks.include?(user_bookmark)

      delete :destroy, :id => user_bookmark.id
      assert_response :success

      assert_false @user.bookmarks.include?(user_bookmark)
      assert_false @user.follows?(user_bookmark)
    end

    should "POST follow & unfollow only once" do
      assert_false @user.follows?(@bookmark)

      2.times do
        post :follow, :id => @bookmark.id
        assert_response :success

        assert @user.follows?(@bookmark)
      end

      2.times do
        post :unfollow, :id => @bookmark.id
        assert_response :success

        assert_false @user.follows?(@bookmark)
      end
    end

    context "that has been liked" do
      setup do
        @old_like_count = @bookmark.likes_count

        post :like, :id => @bookmark.id
        assert_response :success

        3.times do
          post :like, :id => @bookmark.id
        end

        @bookmark.reload
      end

      should "POST like only once" do
        assert_equal (@old_like_count + 1), @bookmark.likes_count
      end

      should "POST unlike only once if it has been liked" do
        @old_like_count = @bookmark.likes_count

        post :unlike, :id => @bookmark.id
        assert_response :success
        @bookmark.reload

        assert_equal (@old_like_count - 1), @bookmark.likes_count

        3.times do
          post :unlike, :id => @bookmark.id
        end
        @bookmark.reload

        assert_equal (@old_like_count - 1), @bookmark.likes_count
      end
    end

    context "with various query parameters" do
      setup do
        @good_queries = [
          # TODO
        ]
        @bad_queries = [
          # TODO
        ]
      end

      should "retrieve the bookmark via different search queries" do
        # TODO
      end

      should "NOT retrieve bookmarks for bad search queries" do
        # TODO
      end
    end
  end

  context "not logged in" do
    setup do
      @bookmark = FactoryGirl.create(:bookmark)
    end

    should "GET index" do
      get :index
      assert_response :success
      assert assigns(:bookmarks).include?(@bookmark)
    end

    should "GET show" do
      get :show, :id => @bookmark.id
      assert_response :success
      assert_equal @bookmark, assigns(:bookmark)
    end

    should "be redirected to login to unauthenticated actions" do
      [:create, :update].each do |action|
        post action, :id => @bookmark.id, :bookmark => FactoryGirl.attributes_for(:bookmark)
        assert_redirected_to login_path
      end

      [:destroy, :like, :follow, :unfollow].each do |action|
        post action, :id => @bookmark.id
        assert_redirected_to login_path
      end
    end
  end
end
