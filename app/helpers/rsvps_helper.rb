module RsvpsHelper

  def get_option(choice)
    @rsvp = Rsvp.find_by(user: current_user, event: @event, choice: choice)
    s = ''
    s += '✓ ' unless @rsvp.nil?
    s += option_text(choice)
  end

  def option_text(choice)
    case choice
    when 1 then 'Going'
    when 2 then 'Interested'
    end
  end

  def button_color(choice)
    if @rsvp.nil?
      'btn btn-default'
    else
      'btn btn-primary'
    end
  end

end
