module EventsHelper
    def list_event(event, col_length)
        string = ''
            string << "<div class='#{col_length} portfolio-item'>"
            string << event_image(event)
            string << "<h4> <a href='#{event_path(event.id)}'> #{event.name}</a></h4>"
            string << "<p>#{truncate event.description, :length => 100}</p>"
            string << start_time(event) + location(event)
            string << '</div>'
        string.html_safe
    end

    def event_image(event)
        <<-eos
		<a href="#{event_path(event.id)}">
		<img class="img-responsive" src="http://placehold.it/295x169" alt="">
		</a>
		eos
    end

    def start_time(event)
        <<-eos
		<div class="row">
		<div class="col-xs-5">
		<span class="glyphicon glyphicon-time" id="icon-home" class="col-md-2"></span>#{event.start.strftime('%m/%d')}
		</div>
		eos
    end

    def location(event)
        <<-eos
		<div class="col-xs-7">
		<div class="text-right">
		<span class="glyphicon glyphicon-map-marker" id="icon-location" class="text-right"></span>#{event.location}
		</div>
		</div>
		</div> <!--closing of location time row-->
		eos
    end

    def sidebar(locations)
        return_string = '<h4>Locations</h4>'
        return_string << sidebar_locations(locations)
        return_string.html_safe
    end

    def sidebar_locations(locations)
        string = ""
		string << "<div id='column_results'>"

		locations.each do |l|
			string << "<p>" + "#{l}" + "</p>" if l != nil
		end

		string << "</div>"

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
