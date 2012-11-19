class Status < ActiveRecord::Base
	has_many :anketas
	
	validates_uniqueness_of :name
end
