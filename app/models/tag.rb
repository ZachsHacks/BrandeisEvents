class Tag < ApplicationRecord
	belongs_to :events
	has_many :event_tags
	belongs_to :users
	has_many :interests
end
