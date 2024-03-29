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

    should "POST report logged in" do
      reason = "404 TESTING: #{UUID.generate(:compact)}"
      post :report, { 
                      :id => @bookmark.id, 
                      :complainer_id => @user.id,
                      :reason => reason
                    }
      assert_response :success

      report = Report.order(:created_at).first

      assert_not_nil report
      assert_equal reason, report.reason
      assert_equal @bookmark.id, report.bookmark.id
      assert_equal @user.id, report.user.id
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

    should "GET share" do
      get :share, :id => @bookmark.id
      assert_response :success
      assert_equal @bookmark, assigns(:bookmark)
    end

    # TODO: Need to change this for mocking!
    should "POST create" do
      tags = []
      5.times do
        tags << Faker::Internet.domain_word
      end
      url = Faker::Internet.url

      post :create, :url => url, :tags => tags
      assert_response :success

      # Find that Bookmark!
      json_response = JSON.parse(@response.body)
      created_bookmark = Bookmark.find(json_response["id"])
      assert_not_nil created_bookmark

      # Check the Tags
      created_bookmark.tags.each do |tag|
        assert tags.include?(tag.name.to_s)
      end

      # Make sure the user follows it
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

      should "POST report not logged in" do
        reason = "404 TESTING: #{UUID.generate(:compact)}"
        post :report, { 
                        :id => @bookmark.id, 
                        :reason => reason
                      }
        assert_response :success

        report = Report.order(:created_at).first

        assert_not_nil report
        assert_equal reason, report.reason
        assert_equal @bookmark.id, report.bookmark.id
        assert_equal nil, report.user
      end
  end
end
