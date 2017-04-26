class EventTag < ApplicationRecord
	belongs_to :tag, counter_cache: :events_count
	belongs_to :event
end
