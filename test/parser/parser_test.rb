require 'test_helper'
require_relative '../../db/brandeis_event_parser'

class ParserTest < ActiveSupport::TestCase

	def setup
		parser = BrandeisEventParser.new
		@data = parser.get_data_xml
	end

	test "no '<br>' tags at the start of description" do
		line = @data.sample
		d = get_description(line["content"])
		bad_description = (d[0, 4] == "<br>")
		assert_not bad_description
	end

	test "parser receives data" do
		assert_not nil, @data
	end

	test "events have title" do
		line = @data.sample
		title = line["title"]
		assert true, title.present?
	end

	test "events have description" do
		line = @data.sample
		d = line["content"]
		assert true, d.present?
	end

	test "events have valid start time" do
		line = @data.sample
		date_time = Time.parse(line["published"].to_s)
		assert_instance_of Time, date_time
	end

	# select methods from seed.rb file

	def get_description(html)
		start = html.index "br"
		description = html[start+9, html.length]
		description_text = Nokogiri::HTML(html).text
		start = description_text.index "m. "
		description_text = description_text[start+3, description_text.length]
		return description.html_safe, description_text
	end

end
