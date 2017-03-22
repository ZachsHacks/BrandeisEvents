require 'faker'

@user_count = User.count

def create_events(x)
	x.times do |event|
		name = Faker::Name.unique.name
		description = Faker::Lorem.paragraph(5)
		start_time = Faker::Time.between(DateTime.now - 1, DateTime.now)
		end_time  = Faker::Time.between(DateTime.now - 1, DateTime.now)
		location = 	Faker::Address.city
		price = rand(50)
		image_id = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRCV8cQhEbPEz0yF0piMIseNgxSAKW7FOImmw7LoWS3wniHvGZW"
		host = rand(@user_count) + 1
		Event.create(name: name, description: description, start: start_time, end: end_time, price: price, host_id: host, location: location, image_id: image_id)
	end

end

create_events(50)
