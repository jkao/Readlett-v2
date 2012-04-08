Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_ID, FACEBOOK_SECRET
  provider :google_oauth2, GOOGLE_ID, GOOGLE_SECRET, {access_type: 'online', approval_prompt: ''}
end
