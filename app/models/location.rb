class Location < ApplicationRecord
	has_many :events
	validates :name, uniqueness: true
end
