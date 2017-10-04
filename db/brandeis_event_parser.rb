require 'crack/xml'
require 'json'
require 'typhoeus'
require 'nokogiri'
require 'byebug'

class BrandeisEventParser

	XML_URL = "http://trumba.com/calendars/brandeis-university.xml"

	JSON_URL = "http://trumba.com/calendars/brandeis-university.json"

	def get_data_xml
		data = Typhoeus.get(XML_URL, followlocation: true).body
		@data_hash = Crack::XML.parse(data)
		@data_array = @data_hash["feed"]["entry"]
		@data_array
	end

	def get_data_json
		data = Typhoeus.get(JSON_URL, followlocation: true).body
		@data = JSON.parse(data)
		@data
	end

end
