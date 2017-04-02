class Event < ApplicationRecord
	has_many :tags, :through => :event_tags
	has_many :event_tags
	validates :name, presence: true, length: { maximum: 50 }
	validates :description, presence: true

	def self.search(search)
		if search
			byebug
			self.where(['lower(name) LIKE ?', "%#{search.downcase}%"]).order('id DESC')
		else
			order('id DESC')
		end
	end

end
