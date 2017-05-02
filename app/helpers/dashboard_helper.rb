module DashboardHelper

    def tab_titles
		['RSVP\'d events', 'Interested Events', 'Events For You', 'Past Events', 'Your Account']
	end

	def section_titles
		['Events you\'re going to', 'Events you\'re interested in', 'Recommended events for you', 'Past events', current_user.name]
	end

end
