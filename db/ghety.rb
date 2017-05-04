# require 'json'
# require 'image_suckr'
# require "ConnectSdk"

# class Ghety
#
# 	def imageUrl(tags)
# create instance of the Connect SDK
# connectSdk = ConnectSdk.new("dxjuk6uxtmdgttrrufcmyvsx", "YuZjDSer9kNfA56mfEuq6ZjuPSekfNKpwCAZkVVdaXvf7")
#
# search_results = connectSdk.search.images.with_phrase("tennis").execute
# byebug
# if !search_results["images"].empty?
# 	  puts "URL: #{search_results["images"][0]["display_sizes"][0]["uri"]}"
# end
a = Hash.new
File.open('db/image_name_dictionary.txt').each do |line|
b,c = line.split(/=/)
  a[b] = c
	puts "First part + " " + #{a[a]}"
	puts "second part + " " + #{c}"
end
byebug
puts "hello"




  # puts image
	# puts "Id: #{image["id"]} URL: #{image["display_sizes"][0]["uri"]}"
# end
# end

# require 'google/image'
#
# resu;Google::Image.search('Keyword')
# byebug
# puts result
