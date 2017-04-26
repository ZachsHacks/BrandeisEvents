module RecommendationHelper

  def recommendations
    user_events = current_user.events
    recs = Set.new

    user_events.each do |e|
      recs = recs + has_common_tag(e)
    end

    recs
  end

  def has_common_tag(e)
    common_tag = Set.new
    Event.all.each do |current_event|
      if (current_event.tags & e.tags).length >= 1 && !current_event.users.include?(current_user)
        common_tag << current_event
      end
    end
    common_tag
  end

end
