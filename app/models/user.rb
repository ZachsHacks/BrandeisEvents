class User < ApplicationRecord
		has_many :events
		has_many :rsvps
		has_many :events, through: :rsvps
		has_many :interests
		has_many :tags, through: :interests
		devise :omniauthable, :omniauth_providers => [:saml]

		# puts "Email =  #{hash.attributes['urn:oid:0.9.2342.19200300.100.1.3']}"
		# puts "UID =  #{hash.attributes['urn:oid:0.9.2342.19200300.100.1.1']}"
		# puts "First name =  #{hash.attributes['urn:oid:2.5.4.42']}"
		# puts "Last name =  #{hash.attributes['urn:oid:2.5.4.4']}"

    class << self
      def from_omniauth(auth_hash)
		data = auth_hash['extra']['raw_info'].attributes
		user = find_or_create_by(uid: data['urn:oid:0.9.2342.19200300.100.1.1'], provider: auth_hash['provider'])
        user.first_name = data['urn:oid:2.5.4.42']
        user.last_name = data['urn:oid:2.5.4.4']
        user.email = data['urn:oid:0.9.2342.19200300.100.1.3']
        user.bio = 'No bio yet...'
        user.save!
        user
      end
    end

    def name
        "#{first_name} #{last_name}"
    end

end
