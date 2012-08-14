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
        @tag.bookmarks << FactoryGirl.create(:bookmark)
      end
    end

    should "be able to assert associations" do
      @tag.bookmarks.each do |bookmark|
        assert bookmark.tags.include?(@tag)
      end
    end
  end
end
