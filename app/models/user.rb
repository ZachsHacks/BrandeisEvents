class User < ApplicationRecord
		has_many :events
		has_many :rsvps
		has_many :events, through: :rsvps
		has_many :interests
		has_many :tags, through: :interests
		devise :omniauthable, :omniauth_providers => [:saml]

    # class << self
    #   def from_omniauth(auth_hash)
    #     user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
	#
    #     user.first_name = auth_hash['info']['first_name']
    #     user.last_name = auth_hash['info']['last_name']
    #     user.email = auth_hash['extra']['raw_info']['email']
    #     user.location = auth_hash['info']['location']
    #     user.image_url = auth_hash['info']['image']
    #     user.bio = 'No bio yet...'
    #     user.save!
    #     user
    #   end
    # end

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		byebug
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    # If you are using confirmable and the provider(s) you use validate emails,
	    # uncomment the line below to skip the confirmation emails.
	    user.skip_confirmation!
  		end
	end

    def name
        "#{first_name} #{last_name}"
    end

end
