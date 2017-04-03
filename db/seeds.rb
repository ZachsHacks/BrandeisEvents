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

	return  data[0].children.text, ""
end

def create_host
	User.create(uid: "calender", provider: "google", first_name: "BrandeisEvents",   email: "calender@brandeis.edu", can_host: true, is_admin: false)
end

def create_tags
	tags = ["religious", "clubs", "food", "academic", "sports"]
	tags.each do |t|
		Tag.create(name: t)
	end
end

def create_locations
	locations = "51 Sawyer Road, Suite 520
	567 South Street Apartments
	60 Turner Street
	Abelson-Bass-Yalem Building
	Abraham Shapiro Academic Complex
	Bassine Science Building
	Berlin Chapel
	Bernstein-Marcus Administration Center
	Bethlehem Chapel
	Brown Social Science Center
	Carl and Ruth Shapiro Admissions Center
	Carl J. Shapiro Science Center
	Charles River Apartments: 110 Angleside - Cohen
	Charles River Apartments: 150 - Coffman
	Charles River Apartments: 164 - Lewis
	Charles River Apartments: 178 - May
	East Quad - Hassenfeld-Krivoff-Shapiro Brothers Hall
	East Quad - Rubenstein-Pomerantz Hall
	East Quad - Swig Hall
	Edison-Lecks Science Building
	Epstein Building
	Faculty Center
	Faculty Lodge
	Farber Library
	Feldberg Communications Center
	Ford Athletic and Recreation Complex
	Foster Bio-Medical Research Center
	Foster Mods 1-9 - Casty
	Foster Mods 10-18 - Casty
	Foster Mods 19-27 - Tobin
	Foster Mods 28-36 - Morris
	Gerstenzang Science Library
	Goldfarb Library
	Golding Health Center
	Golding Judaica Center
	Goldman-Schwartz Art Studios
	Goldsmith Building
	Gosman Sports and Convocation Center
	Gryzmish Center
	Harlan Chapel
	Hassenfeld Conference Center
	Heller-Brown Building
	Irving Presidential Enclave
	Irving Schneider and Family Building (Heller School)
	Jack, Joseph and Morton Mandel Center for Studies in Jewish Education
	Jack, Joseph and Morton Mandel Center for the Humanities
	Kosow-Wolfson-Rosensweig Building
	Kutz Hall
	Landsman Research Facility
	Lemberg Academic Center
	Lemberg Children's Center
	Lemberg Hall
	Linsey Sports Center
	Lown Center for Judaica Studies
	Mailman House
	Main Entrance Information Booth
	Mandel Center for the Humanities
	Massell Quad - DeRoy Hall
	Massell Quad - Renfield Hall
	Massell Quad - Shapiro Hall
	Massell Quad - Usen Hall
	North Quad - Cable Hall
	North Quad - Gordon Hall
	North Quad - Reitman Hall
	North Quad - Scheffres Hall
	Olin-Sang American Civilization Center
	Pearlman Hall
	Pollack Fine Arts Teaching Center
	Rabb Graduate Center
	Rabb School
	Rapaporte Treasure Hall
	Ridgewood Quad - Hall B
	Ridgewood Quad - Hall C
	Ridgewood Quad - Jehuda Reinharz Hall
	Rose Art Museum
	Rose Art Museum Lois Foster Wing
	Rosenstiel Basic Medical Sciences Research Center
	Rosenstiel-Kosow Connector
	Rosenthal Quad - East
	Rosenthal Quad - North
	Rosenthal Quad - South
	Sachar International Center
	Schwartz Hall
	Schwartz Hall - Castle
	Shapiro Athletic Center
	Shapiro Campus Center
	Shapiro Science Center
	Sherman - Hassenfeld Conference Center
	Sherman Student Center / Dining Hall
	Shiffman Humanities Center
	Slosberg Music Center
	Spingold Theater Center
	Stoneman Infirmary and Public Safety
	The Village
	Usdan Student Center
	Usen Castle
	Volen National Center for Complex Systems
	Wein Faculty Center
	Ziv Quad - Hall A
	Ziv Quad - Hall B
	Ziv Quad - Hall D
	Ziv Quad - Mazer Hall"
	locations = locations.split("\n")
	locations.each do |loc|
		loc = loc.gsub("\t", "")
		Location.create(name: loc)
	end
end

create_host
create_locations
create_tags
create_events
