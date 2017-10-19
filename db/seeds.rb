require_relative 'brandeis_event_parser'
require_relative 'tag_dictionary'
require "ConnectSDK"
require 'activerecord-import'

puts "Obtaining Brandeis' Feed..."
#trumba data for brandeis events
@data = BrandeisEventParser.new.get_data_json
byebug
puts "Grabbing Tag Dictionary..."
#dictionary for creating tags (related words)
@dictionary = TagDictionary.new.dictionary

@count = 0

#special cases for image queries
@image_hash = Hash.new

def get_image_url_hash
  if File.file?("db/image_url_dictionary.txt") && !File.zero?("db/image_url_dictionary.txt")
    @image_url_hash =  JSON.parse(File.open("db/image_url_dictionary.txt").read)
  else
    @image_url_hash =  Hash.new
  end
end

def create_events
  Event.update_all(seen_during_seeding: false)
  @locations = Location.all.pluck(:name)
  price_overrides = JSON.parse(File.open("db/price_overrides.txt").read)
  new_events = []
  @data.each do |line|
<<<<<<< HEAD
    title = line["title"]
    description, description_text = line["description"]
		debugger
		if to_b(line["requiresPayment"])#(description.include? "$") && !price_override(title)
			debugger
			price_start_index = description.index("$").to_i + 1
			price_stop_index = description.index(/\s/, price_start_index-1)
			price = description[price_start_index..price_stop_index-1].strip
		end
    location = Nokogiri::HTML(line["location"]).text
    location_id = Location.find_by(name: location).id
    start_time = Time.parse(line["startDateTime"])
	  end_time = Time.parse(line["endDateTime"])
    e = Event.find_or_initialize_by(price: price.to_i || 0, name: title, description: description, description_text: description_text, location: location, location_id: location_id, start: start_time, end: end_time, user: User.first)
=======
    id_line = line["id"]
    trumba_id = id_line.slice(id_line.rindex('/')+1..-1).to_i
    name = line["title"]
    description, description_text = get_description(line["content"])
    if !(price_overrides.include? name)
        if (description.include? "$")
    		price_start_index = description.index("$").to_i + 1
    		price_stop_index = description.index(/\s/, price_start_index-1)
    		price = description[price_start_index..price_stop_index-1].strip
        end
    else
        price = price_overrides[name]
    end
    location = get_location_info(line["content"])
    location_id = Location.find_by(name: location).id
    start = Time.parse(line["published"].to_s)
    e = Event.find_or_initialize_by(trumba_id: trumba_id)
    e.name = name
    e.start = start
    e.user = User.first
    e.price = price.to_i || 0
    e.description = description
    e.description_text = description_text
    e.location = location
    e.location_id = location_id
    e.seen_during_seeding = true
>>>>>>> 8d25810e9d685a8d086420524ce6da39ac599db9
    if e.new_record?
        generate_image(e)
        new_events << e
    else
        e.save(validate: false)
    end
  end
  Event.import new_events, validate: false
  new_events.each { |e| create_tags(e)}

<<<<<<< HEAD
def to_b(string)
	h = { "true"=>true, true=>true, "false"=>false, false=>false }
	return h[string]
end

def price_override(title)
    blacklist = ["Trivia"]
    blacklist.each{ |s| return true if title.include? s }
    return false
=======
  Event.destroy Event.select {|e| !(e.seen_during_seeding || e.start.past?)}
  EventTag.destroy EventTag.select{ |t| !Event.exists?(t.event_id) }
  Rsvp.destroy Rsvp.select{ |r| !Event.exists?(r.event_id) }
>>>>>>> 8d25810e9d685a8d086420524ce6da39ac599db9
end

def generate_image(event)
  split_string = event.name.gsub(/[^0-9a-z ]/i, '')
  split_string = event.name.split()

  if split_string.length>=2
    first_two_words = split_string[0] + " " + split_string[1]
  else
    first_two_words = split_string[0]
  end
  if @image_hash.key?(first_two_words)
    event.image_id = image_url(@image_hash[first_two_words])
  else
    event.image_id = image_url(first_two_words)
  end
end

def get_description(html)
  start = html.index "br"
  description = html[start+9, html.length]
  description_text = Nokogiri::HTML(html).text
  start = description_text.index "m. "
	if !start.nil?
		description_text = description_text[start+3, description_text.length]
	end
  return description.html_safe, description_text
end

def create_host
  User.find_or_create_by(uid: "calendar", provider: "google", first_name: "BrandeisEvents",   email: "calendar@brandeis.edu", can_host: true, is_admin: false)
end

def create_default_tags
  File.open("db/seeds/tags.txt").each do |tag|
    tag = tag.gsub("\t", "")
    tag = tag.gsub("\n", "")
    image = tag
    Tag.find_or_create_by(name: tag, image: image)
  end
  @tags = Tag.all.pluck(:name)
end

def create_tags(event)
  description = event.description
  word_list = get_word_list(description)
  keywords = keywords_from_word_list(word_list)
  tag_names = look_up(keywords)
  tag_names.each do |t|
    tag = Tag.find_or_create_by(name: t.capitalize)
    event.tags << tag unless event.tags.include?(tag)
  end
end

def look_up(keywords)
  if(keywords.empty?)
    return ["Other"]
  end
  keywords.map { |k| @dictionary[k] }.uniq
end

def get_word_list(description)
  wl = (description.gsub(/\W/, ' ').split.map { |w| w.downcase } || event.name.gsub(/\W/, ' ').split.map { |w| w.downcase }).uniq
  wl.map {|word| word.singularize}
end

def keywords_from_word_list(word_list)
  dict_words = @dictionary.keys | @dictionary.values.flatten
  dict_words & word_list
end

def create_locations
  locations = []
  File.open("db/seeds/locations.txt").each do |line|
    line = line.gsub("\t", "")
    line = line.gsub("\n", "")
    locations << Location.new(name: line)
  end
  Location.import locations
end

def image_url(name)
  name = name.gsub("\n", "").downcase
  return @image_url_hash[name] if !@image_url_hash[name].nil?
  @count+= 1
  connectSdk = ConnectSdk.new(ENV["getty_api_key_#{@count%2}"], ENV["getty_api_secret_#{@count%2}"])
  search_results = connectSdk.search.images.with_phrase(name).execute
  if !search_results["images"].nil? && !search_results["images"].empty?
    @image_url_hash[name] = search_results["images"][0]["display_sizes"][0]["uri"].to_s
    return "#{search_results["images"][0]["display_sizes"][0]["uri"]}"
  end
end

def update_image_queries
  File.open('db/image_name_dictionary.txt').each do |line|
    b,c = line.split(/=/)
    @image_hash[b] = c
  end
end

def update_image_url_hash
  output = File.open( "db/image_url_dictionary.txt","w" )
  output.write(@image_url_hash.to_json)
  output.close
end

puts "Starting seeding"
create_host if !User.any?
create_locations if !Location.any?
create_default_tags if !Tag.any?
puts "Updating image queries..."
update_image_queries
puts "Getting image URLs..."
get_image_url_hash
puts "Creating events..."
create_events
puts "Updating image URLs..."
update_image_url_hash
puts "Done!"
