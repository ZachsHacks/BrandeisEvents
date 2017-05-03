require "ConnectSdk"

api_key = "jt7xgbgnyxpvfxtv2kcktehc"
api_secret = "kHXwuuB5NHf7eXhnnF3bMP7YxjHZkYNEGES4bbshvDTUW"

# create instance of the Connect SDK
connectSdk = ConnectSdk.new(api_key, api_secret)
search_results = connectSdk
	.search().images()
	.with_phrase("dog")
	.with_page(2)
	.with_page_size(1)
	.execute()

  puts "URL: #{search_results["images"][0]["display_sizes"][0]["uri"]}"

search_results["images"].each do | image |
  # puts image
	# puts "Id: #{image["id"]} URL: #{image["display_sizes"][0]["uri"]}"
end
