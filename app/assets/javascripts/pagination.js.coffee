jQuery ->
	if $('#infinite-scrolling').size() > 0
		$(window).on 'scroll', ->
			more_events_url = $('.pagination .next_page a').attr('href')
			if more_events_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
				$('.pagination').html('<img src="/assets/images/ajax-loader.gif" alt="Loading..." title="Loading..." />')
				$.getScript more_events_url
				return
	return
