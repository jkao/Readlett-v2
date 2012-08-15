class Report < ActiveRecord::Base
  # Relations
  belongs_to :bookmark, :foreign_key => "complaint_bookmark_id", :class_name => "Bookmark"
  belongs_to :user, :foreign_key => "complainer_user_id", :class_name => "User"

  # Constraints
  validates_presence_of :bookmark
end
