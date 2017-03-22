# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# # config/environments/production.rb
# config.paperclip_defaults = {
#   storage: :s3,
#   s3_credentials: {
#     bucket: ENV.fetch('campusnow-images'),
#     access_key_id: ENV.fetch(''),
#     secret_access_key: ENV.fetch(''),
#     s3_region: ENV.fetch('us-east-1'),
#   }
# }
