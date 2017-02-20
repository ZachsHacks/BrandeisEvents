class Event < ApplicationRecord
	belongs_to :host, :user
end
