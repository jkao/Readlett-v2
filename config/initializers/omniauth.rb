Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_ID, FACEBOOK_SECRET
end
