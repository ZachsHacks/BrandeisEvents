# # require "ConnectSdk"
#
# class Ghety
#
# 	def imageUrl(tags)
# # create instance of the Connect SDK
# connectSdk = ConnectSdk.new(ENV['ghety_api_key'], ENV['ghety_api_secret'])
# search_results = connectSdk
# 	.search().images()
# 	.with_phrase(tags)
# 	.with_page(2)
# 	.with_page_size(1)
# 	.execute()
#
#   puts "URL: #{search_results["images"][0]["display_sizes"][0]["uri"]}"
#
# search_results["images"].each do | image |
#   # puts image
# 	# puts "Id: #{image["id"]} URL: #{image["display_sizes"][0]["uri"]}"
# end

result = ShutterstockRuby::Images.search('Cat') # Returns a hash of the parsed JSON result.
puts result
