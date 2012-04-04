class Rating < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :bookmark
end
