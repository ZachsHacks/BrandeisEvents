Wordnik.configure do |config|
  config.api_key = '5c43d251812f5d116dd5d0df80c0ab2fb760fea7b03af5557'               # required
  config.username = 'bozo'                    # optional, but needed for user-related functions
  config.password = 'cl0wnt0wn'               # optional, but needed for user-related functions
  config.response_format = 'json'             # defaults to json, but xml is also supported
  config.logger = Logger.new('/dev/null')     # defaults to Rails.logger or Logger.new(STDOUT). Set to Logger.new('/dev/null') to disable logging.
end
