class Admin::Ankety::HodnoceniController < ApplicationController
	before_filter :login_required
	before_filter :check_editor_role    

  def destroy
  		@hodnoceni = Hodnoceni.find(params[:id])
  		@hodnoceni.destroy
  		redirect_to :action => 'index'  
  		flash[:notice] = "Hodnocení '#{@hodnoceni.user_body}' bylo úspěšně smázáno."
  end

  def index
   @hodnocenis = Hodnoceni.find_by_sql("SELECT * FROM hodnocenis ORDER BY id DESC")
	#@hodnocenis = Hodnoceni.find(:all)
	getUzivatele
	getOtazky
	getAnkety
  end


private
	def getUzivatele
	
		"
			seznam vsech uzivatelu
		"
		
		if not @users
			@users = User.find(:all)
		end	
	end	

	def getOtazky
	
		"
			seznam vsech otazek
		"
		
		if not @otazkys
			@otazkys = Question.find(:all)
		end	
	end	

	def getAnkety
	
		"
			seznam vsech anket
		"
		
		if not @anketys
			@anketys = Anketa.find(:all)
		end	
	end	

end
