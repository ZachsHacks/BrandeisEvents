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
		return_string = "<br><br>"
		return_string << sidebar_individual_date(@event) +  sidebar_individual_locations(@event) + sidebar_individual_price(@event)
		return_string.html_safe
	end


	def sidebar_individual_date(event)
		<<-eos
		<h3>Date and Time</h3>
		<div id="column_results">
		<p>#{event.start.strftime("%A, %B %e at %l:%M %P") }</p>
		</div>
		eos
	end
	def sidebar_individual_locations(event)
		<<-eos
		<h3>Location</h3>
		<div id="column_results">
		<p>#{event.location}</p>
		</div>
		eos
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
	end


end
