class User < ActiveRecord::Base
  has_many :authorizations
  validates :name, :email, :presence => true

  def add_provider_from_oauth_hash(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    auth = Authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]).nil?
    Authorization.create :user => self,
                         :provider => auth_hash["provider"],
                         :uid => auth_hash["uid"] if auth.nil?
  end
end
