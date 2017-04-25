class User < ApplicationRecord
		has_many :events
		has_many :rsvps
		has_many :events, through: :rsvps
		has_many :interests
		has_many :tags, through: :interests

    class << self
      def from_omniauth(auth_hash)
        user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])

        user.first_name = auth_hash['info']['first_name']
        user.last_name = auth_hash['info']['last_name']
        user.email = auth_hash['extra']['raw_info']['email']
        user.location = auth_hash['info']['location']
        user.image_url = auth_hash['info']['image']
        user.bio = 'No bio yet...'
        user.save!
        user
      end
    end

    def name
        "#{first_name} #{last_name}"
    end

	def get_recommendations
	  user_events = self.events
	  recs = []

	  user_events.each do |e|
		recs << has_common_tag(e)
	  end
	  self.update(recommendations: recs.flatten.uniq)
	end
	handle_asynchronously :get_recommendations

	def has_common_tag(e)
	  common_tag = []
	  e.tags.each do |t|
		  common_tag << t.events.select { |e| !e.users.include?(self)}.map { |e| e.id }
	  end
	  common_tag
	end

end
