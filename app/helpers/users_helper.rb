module UsersHelper

    def get_events_helper
        @user_events = case @active_tab
        when 0
            map_to_events current_user.rsvps.select {|r| r.choice == 1 && !r.event.start.past?}
        when 1
            map_to_events current_user.rsvps.select {|r| r.choice == 2 && !r.event.start.past?}
        when 2
            map_to_events current_user.rsvps.select { |r| r.event.start.past? }
        end

        if @user_events.nil?
            @user_events = []
        end

        @user_events = @user_events.sort_by { |e| e.start  }.paginate(page: params[:page], per_page: 8)
    end

    def map_to_events rsvps
        rsvps.map { |r| r.event }
    end

    def opt_in_or_out(user)
        "Click here to #{privacy_variable(user)} events' RSVP lists!"
    end

    def privacy_variable(user)
        user.hide_rsvp == true ? 'show your name on' : 'hide your name from'
    end

    def privacy_button_color(user)
      user.hide_rsvp == true ? 'btn btn-default' : 'btn btn-danger'
    end

    # def set_active
    #     @active = 0 if @active.nil?
	# 	@tab_classes = []
	# 	@tab_pane_classes = []
	# 	for i in 0..2
	# 		unless i == @active
	# 			@tab_classes[i] = ''
	# 			@tab_pane_classes[i] = 'tab-pane fade'
	# 		end
	# 	end
	# 	@tab_classes[@active] = 'class = active'
	# 	@tab_pane_classes[@active] = 'tab-pane fade in active'
	# end

end
