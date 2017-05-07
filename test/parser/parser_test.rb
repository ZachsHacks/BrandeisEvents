require 'test_helper'
require_relative '../../db/brandeis_event_parser'

class ParserTest < ActiveSupport::TestCase

	def setup
		parser = BrandeisEventParser.new
		@data = parser.get_data
	end

	test "no '<br>' tags at the start of description" do
		bad_descriptions = Event.all.select {|e| e.description[0, 4] == "<br>"}.count
		assert 0, bad_descriptions
	end

	test "parser receives data" do
		assert_not nil, @data
	end


end
