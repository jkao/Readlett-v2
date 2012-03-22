class Bookmark < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :category # TODO: Convert this to join table - multiple categories

  # Validations
  validates_presence_of :title, :link, :user

  # Pagination
  self.per_page = 15

end
