require 'faker'
require_relative 'brandeis_event_parser'

@user_count = User.count

@data = BrandeisEventParser.new.get_data

def create_events

	@data.each do |line|
		title = line["title"]
		description_html = line["content"]
		#location, room = get_location_info(description_html)
		date_time = Time.parse(line["published"].to_s)
		relavent_website = line["gc:weblink"]
		image_id = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRCV8cQhEbPEz0yF0piMIseNgxSAKW7FOImmw7LoWS3wniHvGZW"
		Event.create(name: title, description: description_html, start: date_time, host_id: User.first.id, image_id: image_id)
	end

end

def get_location_info(html)
	parsed_html = Nokogiri::HTML(html)

	data = parsed_html.xpath("//a")

	byebug

	return  "", ""
end

def create_host
	User.create(uid: "calender", provider: "google", first_name: "BrandeisEvents",   email: "calender@brandeis.edu", can_host: true, is_admin: false)
end

create_host
create_events
