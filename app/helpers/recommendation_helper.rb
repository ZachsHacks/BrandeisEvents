module RecommendationHelper

  def recommendations
    user_tags = current_user.events.map { |e| e.tags }.flatten | current_user.tags
    recs = []

    user_tags.each do |t|
      recs << t.events.select { |e| !e.users.include?(current_user) }
    end

    recs.flatten.uniq
  end

end
