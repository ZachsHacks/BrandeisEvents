class Event < ApplicationRecord
	belongs_to :user
	alias_attribute :host, :user
	has_many :rsvps
	has_many :users, through: :rsvps
	has_many :event_tags
	has_many :tags, through: :event_tags

	# has_many :tags, :through => :event_tags
	# has_many :event_tags
	validates :name, presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: {minimum: 80}

	def host
	  user
	end

	has_attached_file :event_image, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>',
		large: '750x240#',
	}

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment_content_type :event_image, :content_type => /\Aimage\/.*\Z/

	def self.search(params)
		if params
			if params[:event]
			name = params[:event].downcase unless params[:event].blank?
			if !params[:location]
				#THis is present so that the all event search bar can search both title and loction
				location = params[:event].downcase
			end
		end
			if params[:location]
			location = params[:location].downcase unless params[:location] == "all"
		end
			# date = Date.strptime(params[:date], '%m/%d/%Y %I:%M %p') unless params[:date].blank?
			#self.where(['lower(name) LIKE ? OR lower(location) LIKE ? OR start LIKE ?', "%#{name}%", "%#{location}%", "%#{date}%"]).order('id DESC')
			if location==name
				self.where(['lower(name) LIKE ? OR lower(location) LIKE ?', "%#{name}%", "%#{location}%"]).order('id DESC')

			else !location==name
			self.where(['lower(name) LIKE ? AND lower(location) LIKE ?', "%#{name}%", "%#{location}%"]).order('id DESC')
end
		else
			order('id DESC')
		end

	end

	def self.all_current_locations
		all.pluck(:location)
	end

	def count_words(string, substring)
			string.scan(/(?=#{substring})/).count
	end


end
