class Feedback < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :message

end
