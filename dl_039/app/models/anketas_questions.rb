class AnketasQuestions < ActiveRecord::Base
	belongs_to :anketa
	belongs_to :question

#  def self.letter letter
#    AnketasQuestion.find :all, :conditions => [ "notice like ?", letter+'%' ] 
#  end
end
