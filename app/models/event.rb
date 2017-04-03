class Event < ApplicationRecord
	belongs_to :user, optional: true
	has_many :rsvps
	has_many :users, through: :rsvps
	has_many :event_tags
	has_many :tags, through: :event_tags

	# has_many :tags, :through => :event_tags
	# has_many :event_tags
	validates :name, presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: {minimum: 80}


	has_attached_file :event_image, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>',
		large: '1170x175#',
	}

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment_content_type :event_image, :content_type => /\Aimage\/.*\Z/

	def self.all_current_locations
		all.pluck(:location)
	end

	def self.search(params)
		if params

			name = params[:event].downcase unless params[:event].blank?
			# location = params[:location].downcase unless params[:location].blank?
			# date = Date.strptime(params[:date], '%m/%d/%Y %I:%M %p') unless params[:date].blank?
			#self.where(['lower(name) LIKE ? OR lower(location) LIKE ? OR start LIKE ?', "%#{name}%", "%#{location}%", "%#{date}%"]).order('id DESC')
			self.where(['lower(name) LIKE ?', "%#{name}%"]).order('id DESC')
		else
			order('id DESC')
		end

	end


end
