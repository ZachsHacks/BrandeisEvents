# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# config/environments/production.rb
config.paperclip_defaults = {
  storage: :s3,
  s3_credentials: {
    bucket: ENV.fetch('campusnow-images'),
    access_key_id: ENV.fetch('AKIAJEFOHRCDEEF3ZQPA'),
    secret_access_key: ENV.fetch('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'),
    s3_region: ENV.fetch('US East'),
  }
}
