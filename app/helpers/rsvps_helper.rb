module RsvpsHelper

  def get_option(event, choice)
    @choice = choice
    @selected = has_rsvp(event) && same_choice(event)

    s = ''
    s += '✓ ' if @selected
    s += option_text
  end

  def has_rsvp(event)
    @rsvps.pluck(:event_id).include?(event.id)
  end

  def same_choice(event)
    !@rsvps.detect { |r| r.event == event and r.choice == @choice }.nil?
  end

  def option_text
    case @choice
    when 1 then 'Going'
    when 2 then 'Interested'
    end
  end

  def rsvp_button_color
    if @selected
      'btn btn-primary'
    else
      'btn btn-default'
    end
  end

end
