class Tag < ApplicationRecord
	has_many :interests
	has_many :users, through: :interests
	has_many :event_tags
	has_many :events, through: :event_tags
end
