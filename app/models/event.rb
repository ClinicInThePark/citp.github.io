class Event < ActiveRecord::Base
	has_many :booths

	#used to allow storage of arrays in db
	serialize :boothlist

	validates :date, presence: true
	validates :location, presence: true
	
end
