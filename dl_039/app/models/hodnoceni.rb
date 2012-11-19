class Hodnoceni < ActiveRecord::Base
	belongs_to :user
	belongs_to :question
	belongs_to :anketa	
end
