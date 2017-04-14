module RsvpsHelper

  def get_option(choice)
    case choice
    when 1 then 'Going'
    when 2 then 'Interested'
    when 3 then 'Not Going'
    end
  end

  def button_color(choice)
    rsvp = Rsvp.find_by(user: current_user, event: @event, choice: choice)
    if rsvp.nil?
      'btn btn-default'
    else
      'btn btn-primary'
    end
  end

end
