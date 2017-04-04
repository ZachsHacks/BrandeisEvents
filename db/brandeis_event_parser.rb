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


end
