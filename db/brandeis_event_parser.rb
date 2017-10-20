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

	def events_xml_has_but_not_json(xml, json)
		xml_data = xml
		json_data = json
		ids = []
		xml_data.each do |event|
			ids.push(event["id"].slice(event["id"].rindex('/')+1..-1).to_i)
		end

		ids1 = []
		json_data.each do |e|
			ids1.push(e["eventID"])
		end
		return ids - ids1
	end

	def grab_extra_xml_events
		xml = get_data_xml
		json = get_data_json
		ids = events_xml_has_but_not_json(xml, json)
		xml = xml.select {|e| ids.include? (e["id"].slice(e["id"].rindex('/')+1..-1).to_i)}
		return xml
	end

end
