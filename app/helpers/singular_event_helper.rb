module SingularEventHelper

	def description
		return_string = <<-eos
		<div class="col-md-10">
		<p>#{@event.description}</p>
		</div>
		eos
		return_string.html_safe
	end


	def sidebar_individual_event
		return_string = ""
		return_string << sidebar_event_sponsor(@event) if !@event.sponsor.blank?
		return_string << sidebar_individual_date(@event) +  sidebar_individual_locations(@event) + sidebar_individual_price(@event)
		return_string.html_safe
	end


	def sidebar_individual_date(event)
		return_string = ""
		return_string << "<h3>Date and Time</h3>"
		return_string << "<div id='column_results'>"
		return_string << "Start: <p>#{event.start.strftime("%A, %B %e at %l:%M %P") }</p>"
		return_string << "End: <p>#{event.end.strftime("%A, %B %e at %l:%M %P") }</p>"
		return_string << "</div>"
		return_string.html_safe
	end

	def sidebar_event_sponsor(event)
		return_string = ""
		return_string << "<h3>Event Sponsor(s)</h3>"
		return_string << "<div id='column_results'>"
		return_string << "<p>#{event.sponsor}</p>"
		return_string << "</div>"
		return_string.html_safe
	end

	def sidebar_individual_locations(event)
		return_string = ""
		return_string << "<h3>Location</h3>"
		return_string << "<div id='column_results'>"
		return_string << "<p>#{event.location}</p>"
		return_string << "</div>"
		return_string.html_safe
	end
	def sidebar_individual_price(event)
		s =""
		s<<"<h3>Price</h3>"
		s<<"<div id='column_results'>"
		if (event.price.nil? || event.price == 0)
			s<< "<p>FREE</p>"
		else
			s<<"<p>$#{event.price}</p>"
		end
		s<<"  </div>"
		s.html_safe
	end





end
