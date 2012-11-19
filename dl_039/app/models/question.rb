class Question < ActiveRecord::Base
	has_and_belongs_to_many :anketas
	has_many :hodnocenis
		
	validates_presence_of :question
	#validates_presence_of :answer

	def ansQue
  		"#{question} #{answer}"
	end

end
