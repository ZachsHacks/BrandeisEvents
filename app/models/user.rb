class User < ApplicationRecord
		has_many :events
		has_many :rsvps

    class << self
      def from_omniauth(auth_hash)
        user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])

        user.first_name = auth_hash['info']['first_name']
        user.last_name = auth_hash['info']['last_name']
        user.email = auth_hash['extra']['raw_info']['email']
        user.location = auth_hash['info']['location']
        user.image_url = auth_hash['info']['image']
        user.bio = 'No bio yet...'
        user.is_host = false
        user.save!
        user
      end
    end

    def name
        first_name + " " + last_name
    end

end
