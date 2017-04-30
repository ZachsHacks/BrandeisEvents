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
		puts "auth_hash = #{auth_hash}"
		@data = auth_hash['extra']['raw_info'].attributes
		puts "@data = #{@data}"
		uid = parse('urn:oid:0.9.2342.19200300.100.1.1')
		user = find_or_create_by(uid: uid, provider: auth_hash['provider'])
        user.first_name = parse('urn:oid:2.5.4.42')
        user.last_name = parse('urn:oid:2.5.4.4')
        user.email = parse('urn:oid:0.9.2342.19200300.100.1.3')
        user.bio = 'No bio yet...'
        user.save!
        user
      end

	  def parse hash
		  puts @data[hash]
		  s = JSON.parse(@data[hash])[0]
		#   puts s
		  @data[hash]
	  end

    end

    def name
        "#{first_name} #{last_name}"
    end

end
