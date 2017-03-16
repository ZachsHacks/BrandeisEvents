module EventsHelper

	def list_events
		count = 0
		string_return = ''
		@events.each do |event|
			string_return = string_return + event_width + event_image(event) + event_name(event) + event_description(event) + start_time(event) + location(event) + '</div>'
		end
		string_return += '</div>'
		string_return.html_safe
	end

	def event_width
		<<-eos
		<div class="col-md-4 portfolio-item">
		eos
	end

	def event_image(event)
		<<-eos
		<a href="#{event_path(event.id)}">
		<img class="img-responsive" src="http://placehold.it/295x169" alt="">
		</a>
		eos
	end

	def event_name(event)
		<<-eos
		<h4>
		<a href="#{event_path(event.id)}"> #{event.name}
		</h4>
		eos

	end

	def event_description(event)
		<<-eos
		<p>#{event.description}</p>
		eos
	end

	def start_time(event)
		<<-eos
		<div class="row">
		<div class="col-xs-6">
		<div>
		<span class="glyphicon glyphicon-time" id="icon-home" class="col-md-2"></span>#{event.start.strftime('%m/%d %I:%M%p')}</div>
		</div>
		eos
	end

	def location(event)
		<<-eos
		<div class="col-xs-6">
		<div class="text-right">
		<span class="glyphicon glyphicon-map-marker" id="icon-location" class="text-right"></span>#{event.location}</div>
		</div>
		</div>
		eos
	end

	def sidebar
		return_string = '<h4>Locations</h4>'
		@events.each do |event|
			return_string += sidebar_locations(event)
		end
		return_string.html_safe
	end

	def sidebar_locations(event)
		<<-eos
		<div id="column_results">
		<p>#{event.location}</p>
		</div>
		eos
	end

	def sidebar_date
		return_string =   <<-eos
		<h4>Dates</h4>
		<div id="column_results">
		<p>
		Today <br/>
		Tomorrow <br/>
		This week <br/>
		Next Week <br/>
		This Month <br/>
		In the future
		</p>
		</div>
		eos
		return_string.html_safe
	end

	# def top_title_image
	#   <div class="container top_page_photo">
	#       <%= image_tag "All-Event-copy_02.png" %>
	#   </div>
	# end

	def search_bar
		search_bar_string = <<-eos
		<div class="row">
		<div class="col-lg-8 col-lg-offset-2">
		<div class="search_bar_events">
		<input type="text" class="form-control" placeholder="Search for...">

		</div>
		<!-- /input-group -->
		</div>
		<!-- /.col-lg-6 -->
		</div>
		eos
		search_bar_string.html_safe


	end

	def sidebar_locations(event)
		<<-eos
		<div id="column_results">
		<p>#{event.location}</p>
		</div>
		eos
	end

	def sidebar_date
		return_string = <<-eos
		<h4>Dates</h4>
		<div id="column_results">
		<p>
		Today <br/>
		Tomorrow <br/>
		This week <br/>
		Next Week <br/>
		This Month <br/>
		In the future
		</p>
		</div>
		eos
		return_string.html_safe
	end

	# def top_title_image
	#   <div class="container top_page_photo">
	#       <%= image_tag "All-Event-copy_02.png" %>
	#   </div>
	# end

	def search_bar
		search_bar_string = <<-eos
		<div class="row">
		<div class="col-lg-8 col-lg-offset-2">
		<div class="search_bar_events">
		<input type="text" class="form-control" placeholder="Search for...">

		</div>
		<!-- /input-group -->
		</div>
		<!-- /.col-lg-6 -->
		</div>
		eos
		search_bar_string.html_safe
	end

end
