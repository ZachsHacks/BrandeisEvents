require 'faker'
require_relative 'brandeis_event_parser'

@user_count = User.count

@data = BrandeisEventParser.new.get_data

def create_events
	@locations = Location.all.pluck(:name)
	@data.each do |line|
		title = line["title"]
		description = get_description(line["content"])
		location = get_location_info(line["content"])
		date_time = Time.parse(line["published"].to_s)
		relavent_website = line["gc:weblink"]
		image_id = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRCV8cQhEbPEz0yF0piMIseNgxSAKW7FOImmw7LoWS3wniHvGZW"
		Event.find_or_create_by(name: title, description: description, location: location, start: date_time, user: User.first, image_id: image_id)
	end

end

def get_description(html)
	d = Nokogiri::HTML(html)
	description = ""
	skip = 3

	d.xpath("//p").children.each do |line|
		description << line.text if skip <= 0 && !line.text.blank?
		description << "\n" if line.name == "br"
		skip -= 1
	end
	description
end

def get_location_info(html)
	parsed_html = Nokogiri::HTML(html)

	data = parsed_html.xpath("//a")
	location = []
	data.each do |line|
		words = line.text.downcase.gsub!(/[^A-Za-z]/, ' ') || line.text.downcase unless line.text.nil?
		location = @locations.select { |l| l.downcase.include? words }
		return location.first if location.size >= 1
		words.split(" ").each do |word|
			location = @locations.select { |l| l.downcase.include? word }
			return location.first if location.size >= 1
		end
	end

	return "Other"
end

def create_host
	User.find_or_create_by(uid: "calendar", provider: "google", first_name: "BrandeisEvents",   email: "calendar@brandeis.edu", can_host: true, is_admin: false)
end
def create_tags
	tag = ["Sports", "Politics", "Music", "Cooking", "Medicine"]
	tag.each do |t|
		Tag.find_or_create_by(name: t)
	end

end

def create_tags
	tags = ["religious", "clubs", "food", "academic", "sports"]
	tags.each do |t|
		Tag.find_or_create_by(name: t)
	end
end

def create_locations
	File.open("db/locations.txt").each do |line|
		line = line.gsub("\t", "")
		line = line.gsub("\n", "")
		Location.find_or_create_by(name: line)
	end
end

def debug_events
	Event.where(location: "Other").each do |e|
		get_location_info(e.description)
	end
end

create_host
create_tags
create_locations
create_events
debug_events
