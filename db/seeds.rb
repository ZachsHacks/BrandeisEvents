require_relative 'brandeis_event_parser'
require_relative 'tag_dictionary'
require "ConnectSDK"
# require_relative 'ghetty'

puts "Obtaining Brandeis' Feed..."
#trumba data for brandeis events
@data = BrandeisEventParser.new.get_data

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
  @locations = Location.all.pluck(:name)
  @data.each do |line|
    title = line["title"]
    description, description_text = get_description(line["content"])
    location = get_location_info(line["content"])
    location_id = Location.find_by(name: location).id
    date_time = Time.parse(line["published"].to_s)
    e = Event.find_or_initialize_by(name: title, description: description, description_text: description_text, location: location, location_id: location_id, start: date_time, user: User.first)
    e.save(validate: false) if e.new_record?
    create_tags(e) if e.save(validate: false)
    generate_image(e) if e.save(validate: false)
    e.save(validate: false)
  end
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
  description_text = description_text[start+3, description_text.length]
  return description.html_safe, description_text
end

def get_location_info(html)
	if html.nil? || html.blank?
		byebug
	end
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
    image = tag
    Tag.find_or_create_by(name: tag[0], image: image)
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
  File.open("db/seeds/locations.txt").each do |line|
    line = line.gsub("\t", "")
    line = line.gsub("\n", "")
    Location.find_or_create_by(name: line)
  end
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
puts "update_image_queries"
update_image_queries
puts "get_image_url_hash"
get_image_url_hash
puts "create_events"
create_events
puts "update_image_url_hash"
update_image_url_hash
puts "Done!"
