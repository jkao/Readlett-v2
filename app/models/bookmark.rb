class Bookmark < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :bookmark_user_entries
  has_many :likes
  has_and_belongs_to_many :tags

  # Validations
  validates_presence_of :title, :url

  # Pagination
  self.per_page = 15

  def self.get_recent(age = nil)
    ordered_bookmarks = self.order("created_at DESC")
    age.nil? ? ordered_bookmarks : ordered_bookmarks.where("created_at > ?", Time.zone.now - age)
  end

  def self.get_popular(age = 1.month)
    self.safe_query \
        #.where("bookmarks.created_at > ?", (Time.now.utc - age))
        .order("bookmarks.views ASC, bookmarks.likes_count ASC, bookmarks.id DESC")
  end

  def self.search(query)
    self.safe_query
        .where("bookmarks.title LIKE ? OR bookmarks.description LIKE ?", query, query) \
        .order("bookmarks.views ASC, bookmarks.likes_count ASC, bookmarks.id DESC")
  end

  def self.safe_query
    self.where(:private => false, :nsfw => false)
  end

  def increment_view!
    self.views += 1
    self.save!
  end

  def like!(user)
    return if user.likes?(self)

    transaction do
      self.likes_count += 1
      self.save!
      Like.create(:user => user,
                  :bookmark => self)
    end
  end

  def unlike!(user)
    return unless user.likes?(self)

    transaction do
      self.likes_count -= 1
      self.save!
      Like.where(:user_id => user.id,
                 :bookmark_id => self.id).first.destroy
    end
  end

  def follow!(user)
    return if user.follows?(self)
    BookmarkUserEntry.create(:bookmark => self,
                             :user => user,
                             :current_url => self.url)
  end

  def unfollow!(user)
    return unless user.follows?(self)
    BookmarkUserEntry.where(:bookmark_id => self.id,
                            :user_id => user.id).first.destroy
  end

  def safe_delete(user)
    self.unfollow!(user)
    self.user_id = nil
    self.save!
  end

  # Determine if a user account is the creator of a bookmark
  def is_owner?(user)
    user && (self.user_id == user.id)
  end

  # Determine if a user has permission to view a bookmark
  def user_can_see?(user)
    !self.private || self.is_owner?(user)
  end

end
