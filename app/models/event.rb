require 'time'
class Event < ApplicationRecord
	belongs_to :user
	alias_attribute :host, :user
	has_many :rsvps
	has_many :users, through: :rsvps
	has_many :event_tags
	has_many :tags, through: :event_tags

	validates :name, presence: true, allow_blank: false, length: { maximum: 50, minimum: 1 }
	validates :description, presence: true, allow_blank: false, length: { minimum: 80 }
	validates :location, presence: true
	validates :start, presence: true
	validates :trumba_id, uniqueness: true


	def host
		user
	end

	def url
		"deistoday.com/events/#{self.id}"
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
			events = Event.all
			#name or description
			n_or_d = params[:event]
			location = params[:location]
			date = params[:date] || Time.now
			date = Date.strptime(params[:date].to_s, "%m/%d/%Y")
			events = events.where(['start > ? AND end < ?'], "%#{date}%", "%#{date.end_of_day}%")
			events = events.where(['lower(name) LIKE ? OR lower(description) LIKE ?', "%#{n_or_d.downcase}%", "%#{n_or_d.downcase}%"]) if n_or_d.present?
			events = events.where(['lower(location) LIKE ?',"%#{location.downcase}%"]) if location.present? && location != "all"
			events = events.where(:start => date.beginning_of_day..date.end_of_day) if date.present?

			return events

		else
			Event.where('start > ?', Time.now).order('id ASC')
		end
	end

end
