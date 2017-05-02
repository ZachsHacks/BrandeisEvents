class User < ApplicationRecord
		has_many :events
		has_many :rsvps
		has_many :events, through: :rsvps
		has_many :interests
		has_many :tags, through: :interests
		devise :omniauthable, omniauth_providers: [:saml]

		# validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }

    class << self
      def from_saml(auth_hash)
		puts "auth_hash = #{auth_hash}"
		@data = auth_hash['extra']['raw_info'].attributes
		puts "@data = #{@data}"
		uid = parse('urn:oid:0.9.2342.19200300.100.1.1')
		user = find_or_create_by(uid: uid, provider: auth_hash['provider'])
		@new_record = user.new_record?
        user.first_name = parse('urn:oid:2.5.4.42')
        user.last_name = parse('urn:oid:2.5.4.4')
        user.email = parse('urn:oid:0.9.2342.19200300.100.1.3')
        user.bio = 'No bio yet...'
        user.save!
        user
      end

	  def parse key
		  @data[key][0]
	  end

	  def from_google(auth_hash)
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

end
