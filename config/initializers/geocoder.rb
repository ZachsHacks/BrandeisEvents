# config/initializers/geocoder.rb
Geocoder.configure(

  # street address geocoding service (default :nominatim)
  lookup: :google,
  api_key: ENV['Google_Maps_API'],

  # IP address geocoding service (default :ipinfo_io)
  ip_lookup: :maxmind,

  # geocoding service request timeout, in seconds (default 3):
  timeout: 5,

  # set default units to kilometers:
  units: :mi,

  # # caching (see [below](#caching) for details):
  # cache: Redis.new,
  # cache_prefix: "..."
)
