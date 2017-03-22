class Event < ApplicationRecord
	belongs_to :user, optional: true
	has_many :rsvps
	has_many :users, through: :rsvps
	has_many :event_tags
	has_many :tags, through: :event_tags

	# has_many :tags, :through => :event_tags
	# has_many :event_tags
	validates :name, presence: true, length: { maximum: 50 }
	validates :description, presence: true, length: {minimum: 80}

	def self.search(search)
		if search
			self.where(['name LIKE ?', "%#{search}%"]).take(50)
		else
			self.all.take(50)
		end
	end

end
