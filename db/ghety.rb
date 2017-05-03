require 'json'
require 'image_suckr'
require "ConnectSdk"

# class Ghety
#
# 	def imageUrl(tags)
# create instance of the Connect SDK
connectSdk = ConnectSdk.new(ENV['ghety_api_key'], ENV['ghety_api_secret'])

search_results = connectSdk.search.images.with_phrase("Helène Aylon | Afterword: For the Children").execute
if !search_results["images"].empty?
	  puts "URL: #{search_results["images"][0]["display_sizes"][0]["uri"]}"
end





  # puts image
	# puts "Id: #{image["id"]} URL: #{image["display_sizes"][0]["uri"]}"
# end
# end

# require 'google/image'
#
# resu;Google::Image.search('Keyword')
# byebug
# puts result
