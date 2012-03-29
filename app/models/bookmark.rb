class Bookmark < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :category # TODO: Convert this to join table - multiple categories

  # Validations
  validates_presence_of :title, :link, :user

  # Pagination
  self.per_page = 15

  def self.get_latest
  end

  # Order by:
  # 1. # Users Bookmarking it
  # 2. # 'Likes'/Comments
  # 3. # Date Created
  def self.get_popular
  end

  def self.get_popular
  end

end
