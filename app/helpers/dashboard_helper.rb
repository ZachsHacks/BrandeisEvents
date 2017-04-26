module DashboardHelper

    def tab_titles
		['RSVP\'d events', 'Interested Events', 'Events For You', 'Your Account']
	end

	def section_titles
		['Events you\'re going to', 'Events you\'re interested in', 'Recommended events for you', current_user.name]
	end

end
