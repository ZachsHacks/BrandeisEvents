module RsvpsHelper

  def get_option(event, choice)
    @choice = choice
    @selected = has_rsvp(event) && same_choice(event)

    s = ''
    s += '✓ ' if @selected
    s += option_text
  end

  def has_rsvp(event)
    current_user.rsvps.pluck(:event_id).include?(event.id)
  end

  def same_choice(event)
    !current_user.rsvps.find_by(event: event, choice: @choice).nil?
  end

  def option_text
    case @choice
    when 1 then 'Going'
    when 2 then 'Interested'
    end
  end

  def button_color
    if @selected
      'btn btn-primary'
    else
      'btn btn-default'
    end
  end

end
