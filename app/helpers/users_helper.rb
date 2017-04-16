module UsersHelper

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
