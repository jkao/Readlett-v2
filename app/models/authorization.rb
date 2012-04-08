class Authorization < ActiveRecord::Base
  # Associations
  belongs_to :user

  # Validations
  validates_presence_of :provider, :uid
end
