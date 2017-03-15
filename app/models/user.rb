class User < ApplicationRecord

    class << self
      def from_omniauth(auth_hash)
        user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
        byebug
        user.first_name = auth_hash['info']['first_name']
        #byebug
        user.last_name = auth_hash['info']['last_name']
        #byebug
        user.name = user.first_name + ' ' + user.last_name
        #byebug
        user.email = auth_hash['extra']['raw_info']['email']
        user.location = auth_hash['info']['location']
        user.image_url = auth_hash['info']['image']
        user.bio = 'No bio yet...'
        user.is_host = false
        user.save!
        user
      end
    end

end
