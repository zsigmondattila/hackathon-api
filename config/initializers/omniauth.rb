Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '403536826622-qtg9u828547dh70mo0pgh8ofc4g0v3vl.apps.googleusercontent.com', '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'
  end