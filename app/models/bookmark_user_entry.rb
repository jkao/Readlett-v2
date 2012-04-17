class BookmarkUserEntry < ActiveRecord::Base

  # Associations
  belongs_to :bookmark
  belongs_to :user

end
