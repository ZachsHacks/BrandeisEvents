module UsersHelper

    def gather_user_events
		@going_rsvps = current_user.rsvps.select {|r| r.choice == 1}
	    @interested_rsvps = current_user.rsvps.select {|r| r.choice == 2}
	end

    def get_events index
        rsvps = case index
        when 0
            current_user.rsvps.select {|r| r.choice == 1}
        when 1
            current_user.rsvps.select {|r| r.choice == 2}
        else recommendations
        end

        @user_events = rsvps.map { |r| r.event }
    end

    def set_active
        @active = 0 if @active.nil?
		@tab_classes = []
		@tab_pane_classes = []
		for i in 0..2
			unless i == @active
				@tab_classes[i] = ''
				@tab_pane_classes[i] = 'tab-pane fade'
			end
		end
		@tab_classes[@active] = 'class = active'
		@tab_pane_classes[@active] = 'tab-pane fade in active'
	end

end
