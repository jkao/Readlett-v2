require 'test_helper'

class TagTest < ActiveSupport::TestCase
  context "A newly created tag" do
    setup do
      @tag = FactoryGirl.build(:tag)
    end

    should "convert to lower case" do
      code = "ABCDEFGHI"
      @tag.code = code
      @tag.save!

      assert_equal code.downcase.intern, @tag.code
    end
  end

  context "A tag with multiple bookmarks" do
    setup do
      @tag = FactoryGirl.create(:tag)
      3.times do
        @tag.bookmarks << FactoryGirl.create(:bookmark, :tag => @tag)
      end
    end

    should "be able to assert associations" do
    end
  end
end
