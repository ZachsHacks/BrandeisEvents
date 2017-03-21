class EventTag < ApplicationRecord
	has_many :tags
	has_many :events
end
