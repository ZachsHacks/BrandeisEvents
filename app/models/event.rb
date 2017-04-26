require 'time'
class Event < ApplicationRecord
	belongs_to :user
	alias_attribute :host, :user
	has_many :rsvps
	has_many :users, through: :rsvps
	has_many :event_tags
	has_many :tags, through: :event_tags

	# has_many :tags, :through => :event_tags
	# has_many :event_tags
	if @manual
		validates :name, presence: true, allow_blank: false, length: { maximum: 50, minimum: 1 }
		validates :description, presence: true, allow_blank: false, length: { minimum: 80 }
	end

	def host
		user
	end

	has_attached_file :event_image, styles: {
		thumb: '100x100>',
		square: '200x200#',
		medium: '300x300>',
		large: '750x240#'
	}

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment_content_type :event_image, content_type: /\Aimage\/.*\Z/

	def self.search(params)
		if params
			if params[:event]
				name = params[:event].downcase unless params[:event].blank?
				# THis is present so that the all event search bar can search both title and loction
				location = params[:event].downcase unless params[:location] == 'all'
			end
			if params[:location]
				location = params[:location].downcase unless params[:location] == 'all'
			end

			if location == name
				where(['lower(name) LIKE ? OR lower(description) LIKE ? OR lower(location) LIKE ?', "%#{name}%", "%#{name}%", "%#{location}%"]).order('id ASC')
			#d = Date.strptime(params[:date], "%m/%d/%Y")
			else location != name
				if (params[:event].present? && params[:location].present?)
					where(['lower(name) LIKE ? AND lower(description) LIKE ? AND lower(location) LIKE ?', "%#{name}%", "%#{name}%", "%#{location}%"]).order('id ASC')
				elsif (!params[:event].present? && params[:location].present?)
					where(['lower(location) LIKE ?', "%#{location}%"]).order('id DESC')
				else
					where(['lower(name) LIKE ? OR lower(description) LIKE ? OR lower(location) LIKE ?', "%#{name}%", "%#{name}%", "%#{location}%"]).order('id ASC')
				end
			end
		else
			order('id ASC')
		end
	end

	def description_plain_text
		Nokogiri::HTML(self.description).text
	end
end
