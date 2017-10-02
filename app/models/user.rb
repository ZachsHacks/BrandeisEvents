class User < ApplicationRecord
	has_many :events
	has_many :rsvps
	has_many :events, through: :rsvps
	has_many :interests
	has_many :tags, through: :interests
	devise :omniauthable, omniauth_providers: [:saml]

	validates :phone, :allow_blank => true, format: { with:  /\d[0-9]\)*\z/, message: "bad format" }, :numericality => true, length: {minimum: 10, maximum: 10}

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
			user.calendar_hash = User.digest("#{user.uid}#{user.provider}").gsub!(/[^0-9A-Za-z]/, '')
			user.save!
			user
		end

		def parse key
			@data[key][0]
		end

	end

	def name
		"#{first_name} #{last_name}"
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

end
