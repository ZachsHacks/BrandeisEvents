require 'faker'
require_relative 'brandeis_event_parser'
require_relative 'tag_dictionary'

@user_count = User.count

#trumba data for brandeis events
@data = BrandeisEventParser.new.get_data

#dictionary for creating tags (related words)
@dictionary = TagDictionary.new.dictionary


def create_events
	@locations = Location.all.pluck(:name)
	@data.each do |line|
		title = line["title"]
		description = get_description(line["content"])
		location = get_location_info(line["content"])
		date_time = Time.parse(line["published"].to_s)
		relevant_website = line["gc:weblink"]
		image_id = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRCV8cQhEbPEz0yF0piMIseNgxSAKW7FOImmw7LoWS3wniHvGZW"
		e = Event.find_or_create_by(name: title, description: description, location: location, start: date_time, user: User.first, image_id: image_id)
		create_tags(e) if e.save
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

def create_default_tags
	File.open("db/seeds/tags.txt").each do |tag|
		tag = tag.gsub("\t", "")
		tag = tag.gsub("\n", "")
		Tag.find_or_create_by(name: tag)
	end
	@tags = Tag.all.pluck(:name)
end

def create_tags(event)
	description = event.description
	word_list = get_word_list(description)
	keywords = keywords_from_word_list(word_list)
tag_names = look_up(keywords)
	tag_names.each do |t|
	 	event.tags << Tag.find_by(name: t.capitalize)
		#event.tags.create(name: t.capitalize)
	end
end

def look_up(keywords)
	if(keywords.empty?)
		return ["Other"]
	end
	keywords.map { |k| @dictionary[k] }.uniq
end

def get_word_list(description)
	(description.gsub(/\W/, ' ').split.map { |w| w.downcase } || event.name.gsub(/\W/, ' ').split.map { |w| w.downcase }).uniq
end

def keywords_from_word_list(word_list)
	dict_words = @dictionary.keys | @dictionary.values.flatten
	dict_words & word_list
end

def create_locations
	File.open("db/seeds/locations.txt").each do |line|
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
create_locations if !Location.any?
create_default_tags if !Tag.any?
create_events
# debug_events
