class Bookmark < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_and_belongs_to_many :tags

  # Validations
  validates_presence_of :title, :link, :user

  # Pagination
  self.per_page = 15

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
  def self.get_recent
    self.public_filter.order("id DESC")
  end

  def self.increment_view!
    self.view += 1
    self.save!
  end

end
