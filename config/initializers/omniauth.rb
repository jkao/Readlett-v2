Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, Configuration.facebook_id, Configuration.facebook_secret
end
