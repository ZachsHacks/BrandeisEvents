Rails.application.config.middleware.use OmniAuth::Builder do

  provider OmniAuth::Strategies::GoogleOauth2,
  '865024761143-n55m4diodacl1bkgclam8nbq09q7rl4n.apps.googleusercontent.com',
  '0IVZqF3YUCpZa1eeAc_wuXOE', scope: 'profile email', image_aspect_ratio: 'square',
  image_size: 48, access_type: 'online', name: 'google'

end
