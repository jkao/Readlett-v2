class Like < ActiveRecord::Base

  # Assocations
  belongs_to :user
  belongs_to :bookmark

end
