require 'test_helper'

class ParserTest < ActiveSupport::TestCase

	test "no '<br>' tags at the start of description" do
		bad_descriptions = Event.all.select {|e| e.description[0, 4] == "<br>"}.count
		assert 0, bad_descriptions
	end

end
