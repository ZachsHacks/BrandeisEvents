module RecommendationHelper

  def recommendations
    user_events = current_user.events

    recs = []

    user_events.each do |e|
      recs = recs + Event.where("name ILIKE ?", "%#{e.name}%")
    end

    return recs
  end

end
