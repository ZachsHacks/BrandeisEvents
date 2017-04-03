require 'crack/xml'
require 'typhoeus'
require 'nokogiri'

class BrandeisEventParser

	URL = "http://trumba.com/calendars/brandeis-university.xml"

	def get_data
		data = Typhoeus.get(URL, followlocation: true).body
		@data_hash = Crack::XML.parse(data)
		@data_array = @data_hash["feed"]["entry"]
		@data_array
	end

	def parse_data
		@data_array.each do |line|
			title = line["title"]
			description_html = line["content"]
			date_time = Time.parse(line["published"].to_s)
			relavent_link = line["gc:weblink"]
		end
	end

	def parse_description

	end

end
