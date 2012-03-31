class Bookmark < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :category # TODO: Convert this to join table - multiple categories

  # Validations
  validates_presence_of :title, :link, :user

  # Pagination
  self.per_page = 16

  # Order by:
  # 1. Users Bookmarking it
  # 2. Likes/Comments
  # 3. Date Created
  def self.get_popular
    # TODO
  end

  def self.public_filter
    self.where(:private => false, :nsfw => false)
  end

  # Returns Most Recent Bookmarks
  def self.get_recent(lim = 16)
    self.public_filter.order("id DESC").limit(lim)
  end

end
