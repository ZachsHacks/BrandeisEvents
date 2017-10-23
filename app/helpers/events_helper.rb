require 'nokogiri'

module EventsHelper
	def top_image_text
		s = ''
		s << if params[:date] && params[:date] != ''
			params[:date].titleize.to_s
		elsif params[:tag]
			"Category: #{Tag.find(params[:tag]).name.titleize}"
		elsif params[:location] && params[:location] != 'all'
			params[:location].titleize.to_s
		else
			'All Events'
		end
		s.html_safe
	end

	def list_event_helper(event, col_length)
		string = ''
		string << "<div class='#{col_length} portfolio-item'>"
		string << event_image(event)
		string << "<h4> <a href='#{event_path(event.id)}'> #{truncate event.name, length: 50}</a></h4>"
		string << list_tags(event)
		if event.host.first_name == "BrandeisEvents"
			string << "<p class='event-description-home'>#{(truncate event.description_text, length: 65)}</p>"
		else
			string << "<p>#{(truncate event.description, length: 65)}</p>"
		end
		string << start_time(event) + location(event)
		# string << '</div>'
		string.html_safe
	end

	def list_tags(e)
		string = "<div class='text-left event-tags'>"
		icon = "<span class='glyphicon glyphicon-tags' class='col-md-2'></span>"
		string << "<p>#{icon} #{truncate top_tags(e), length: 70}  </p>"
		string << '</div>'
	end

	def top_tags(e)
		tags = e.tags.pluck(:name).sort
		if tags.count >= 3
			return "#{tags[0]}, #{tags[1]}, #{tags[2]}"
		elsif tags.count == 2
			return "#{tags[0]}, #{tags[1]}"
		else tags[0]
		end
	end

	def event_image(event)
		s = ''
		s << "<a href='#{event_path(event.id)}'>"
		if event.event_image_file_name.nil?
			if event.image_id.blank?
				s << image_tag('missing_thumbnail.png').html_safe
			else
				s << image_tag(event.image_id).html_safe
			end
		else
			s << image_tag(event.event_image(:square)).html_safe
		end
		s << '</a>'
	end

	def start_time(event)
		<<-eos
		<div class="row">
		<div class="col-xs-12">
		<span class="glyphicon glyphicon-time" id="icon-home" class="col-md-4"></span>#{event.start.strftime('%-m/%-d %l:%M %p')}
		</div>
		eos
	end

	def location(event)
		string = "<div class='col-xs-12'>"
		string << "<span style='margin-left: -21px;' class='glyphicon glyphicon-map-marker' id='icon-location'></span>"
		to_truncate = event.location
		trunc = to_truncate.split.first(2).join(' ')
		string << " " + trunc.to_s
		string << '</div>'
		string << '</div>'
	end

	def sidebar(locations)
		string = ''
		string << "<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#locations'><h4><strong>Locations</strong></h4></button>"
		string << "<div class='collapse' id='locations'>"
		string << '<p>' + link_to('All Locations', filter_events_path, remote: true) + '</p>'

		locations.sort.each do |l|
			count = l.events.where('start > ?', Date.today).count.to_s
			s = l.name + ' (' + count + ')'
			string << '<p>' + link_to(s, filter_events_path(location: l.name), remote: true) + '</p>'
		end

		string << '</div>'
		string.html_safe
	end

	def sidebar_tags
		string = ''
		string << "<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#tags'><h4><strong>Categories</strong></h4></button>"
		string << "<div class='collapse' id='tags'>"
		string << '<p>' + link_to('All Categories', filter_events_path, remote: true) + '</p>'
		Tag.all.select { |t| t.events.count > 0 }.sort.each do |tag|
			s = ' (' + Tag.find(tag.id).events.count.to_s + ')'
			string << '<p>' + link_to(tag.name + s, filter_events_path(tag: tag.id), remote: true) + '</p>'
		end

		string << '</div>'
		string << '<hr>'
		string.html_safe
	end

	def sidebar_date
		string = ''
		string << "<button type='button' class='btn btn-link' data-toggle='collapse' data-target='#dates'><h4><strong>Dates</strong></h4></button>"
		string << "<div class='collapse' id='dates'>"
		string << '<p>' + link_to('All Dates', filter_events_path, remote: true) + '</p>'
		string << '<p>' + link_to('Today', filter_events_path(date: 'today'), remote: true) + '</p>'
		string << '<p>' + link_to('Tomorrow', filter_events_path(date: 'tomorrow'), remote: true) + '</p>'
		string << '<p>' + link_to('This Week', filter_events_path(date: 'this week'), remote: true) + '</p>'
		string << '<p>' + link_to('This Weekend', filter_events_path(date: 'this weekend'), remote: true) + '</p>'
		string << '<p>' + link_to('Next Week', filter_events_path(date: 'next week'), remote: true) + '</p>'
		string << '<p>' + link_to('This Month', filter_events_path(date: 'this month'), remote: true) + '</p>'
		string << '<p>' + link_to('Past Events', filter_events_path(date: 'past events'), remote: true) + '</p>'
		string << '</div>'
		string << '<hr>'
		string.html_safe
	end

	def is_host
		current_user && @event.host == current_user
	end

	def time_to_destination(starting, destination, type)
		s = ''
		drive_time_in_minutes = GoogleDirections.new(starting, destination, type).drive_time_in_minutes
		hours = drive_time_in_minutes / 60
		minutes = drive_time_in_minutes % 60
		s = hours.to_s + ' hours ' + minutes.to_s + ' minutes'

		s.html_safe
	end
end
