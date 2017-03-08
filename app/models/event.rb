class Event < ApplicationRecord
	has_many :tags, through: :event_tags
	# validates :name , presence: true
	# validates :description , presence: true
	# validates :location , presence: true
end
