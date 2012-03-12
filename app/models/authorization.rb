class Authorization < ActiveRecord::Base
  belongs_to :user
  validates :provider, :uid, :presence => true

  def self.find_or_create_from_oauth_hash(auth_hash)
    auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

    if auth.nil?
      user = User.create :name => auth_hash["user_info"]["name"],
                         :email => auth_hash["user_info"]["email"]
      auth = Authorization.create :user => user,
                                  :provider => auth_hash["provider"],
                                  :uid => auth_hash["uid"]
    end

    auth
  end
end
