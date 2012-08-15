class User < ActiveRecord::Base

  # Associations
  has_many :authorizations
  has_many :bookmarks
  has_many :bookmark_user_entries
  has_many :likes
  has_many :reports, :foreign_key => "complainer_user_id", :class_name => "Report"

  # Validations
  validates_presence_of :name, :email

  def likes?(bookmark)
    like = Like.where(:user_id => self.id,
                      :bookmark_id => bookmark.id).first
    !like.nil?
  end

  def follows?(bookmark)
    !current_bookmark_user_entry(bookmark).nil?
  end

  def update_bookmark_position(bookmark, new_url)
    bookmark_entry = current_bookmark_user_entry(bookmark)

    if bookmark_entry.nil?
      bookmark.follow!(user)
    else
      BookmarkUserEntry.create(:bookmark => bookmark,
                               :user => self,
                               :current_url => new_url)
    end
  end

  def current_url(bookmark)
    return nil unless self.follows?(bookmark)
    current_bookmark_user_entry(bookmark).current_url
  end

  def current_bookmark_user_entry(bookmark)
    bookmark_user_entry = BookmarkUserEntry.where(:user_id => self.id,
                                                  :bookmark_id => bookmark.id) \
                                            .order("created_at DESC") \
                                            .first
  end

end
