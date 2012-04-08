class User < ActiveRecord::Base

  # Associations
  has_many :authorizations
  validates_presence_of :name, :email

end
