module DashboardHelper

    def tab_titles
		# ['RSVP\'d events', 'Interested Events', 'Recommended Events', 'Past Events', 'Your Account']
        ['RSVP\'d events', 'Interested Events', 'Past Events']
	end

	def section_titles
		# ['Events you\'re going to', 'Events you\'re interested in', 'Recommended events for you', 'Past events', current_user.name]
        ['Events you\'re going to', 'Events you\'re interested in', 'Past events']
	end

end
