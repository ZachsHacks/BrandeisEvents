require 'faker'

@user_count = User.count

def create_events(x)
	x.times do |event|
		name = Faker::Name.unique.name
		description = Faker::Lorem.paragraph(5)
		start_time = Faker::Time.between(DateTime.now - 1, DateTime.now)
		end_time  = Faker::Time.between(DateTime.now - 1, DateTime.now)
		price = rand(50)
		host = rand(@user_count) + 1
		Event.create(name: name, description: description, start: start_time, end: end_time, price: price, host_id: host)
	end

end

create_events(50)
