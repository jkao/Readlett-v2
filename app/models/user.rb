class User < ActiveRecord::Base

  # Associations
  has_many :authorizations
  validates :name, :email, :presence => true

  # Filters
  before_save :set_lowercase!

  def self.create_or_add_provider(auth_hash, current_user_id = nil)
    if current_user_id.nil?
      # Need to create and authenticate user
      auth = Authorization.find_or_create_from_oauth_hash(auth_hash)
      current_user_id = auth.user.id
    else
      # User has already signed in - add another provider
      User.find(current_user_id).add_provider_from_oauth_hash(auth_hash)
    end
    current_user_id
  end

  def add_provider_from_oauth_hash(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    auth = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]).nil?
    Authorization.create :user => self,
                         :provider => auth_hash["provider"],
                         :uid => auth_hash["uid"] if auth.nil?
  end

  private

  def set_lowercase!
    self.email = self.email.downcase unless self.email.nil?
    self.save!
  end
end
