class Event < ApplicationRecord
	has_many :event_tags
	validates :name , presence: true
	validates :description , presence: true
	validates :location , presence: true
	validates :start , presence: true
end
