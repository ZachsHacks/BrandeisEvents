class EventTag < ApplicationRecord
	has_many :tags
	belongs_to :events
end
