class Admin::Ankety::QuestionController < ApplicationController
	before_filter :login_required
	before_filter :check_editor_role    

   def new
 	   @question = Question.new 
		@page_title = 'Vytvoření nové otázky'
   end

	def create
  		@question = Question.new(params[:question])
		getTyteOtazky
	end

	def getTyteOtazky
      
      "		
		 rozhodne o jaky typ otazky se jedna
      "
      @question.mark_total = @question.mark_total * @question.votes_total 
      @question.pocet_odpovedi = @question.answer.split("\r\n").length
      if @question.question !="" and @question.answer == "" and @question.position ==0
    		if @question.save
      		flash[:notice] = "Otázka #{@question.question} byla úspěšně přidána."
   	   	#redirect_to :action => 'index'  
   	   	redirect_to :action => 'new' # pro urychleni zadavani, vse probehlo ok
  		   else
    		   @page_title = 'Vytvoření nové otázky'
    		   render :action => 'new'
    		end   
      elsif @question.question != "" and @question.pocet_odpovedi >= @question.position
         # vyberova otazka
    		if @question.save
      		flash[:notice] = "Otázka #{@question.question} byla úspěšně přidána."
   	   	#redirect_to :action => 'index'  
   	   	redirect_to :action => 'new' # pro urychleni zadavani, vse probehlo ok
  		   else
    		   @page_title = 'Vytvoření nové otázky'
    		   render :action => 'new'
  		   end
      elsif @question.question == ""
 		   @page_title = 'Nezada-li jste otázku.'
    		render :action => 'new' 
  		else
 		   @page_title = 'Číslo správné odpovědi (číslo řádku) nesmí byt větší jak počet řádků.'
    		render :action => 'new' 
      end  			
	end

	def edit
  		@question = Question.find(params[:id])
  		@page_title = 'edituj otázku' 
	end

	def update	
  		@questionUpd = Question.find(params[:id])
      @question = Question.new(params[:question])
      params[:question][:mark_total] = @question.mark_total * @question.votes_total 
      @question.pocet_odpovedi = @question.answer.split("\r\n").length
      if @question.question !="" and @question.answer == "" and @question.position ==0
    		if @questionUpd.update_attributes(params[:question])
      		flash[:notice] = "Otázka #{@question.question} byla úspěšně přidána."
   	   	redirect_to :action => 'index'
  		   else
    		   @page_title = 'editace'
    		   render :action => 'edit'
    		end   
      elsif @question.question != "" and @question.pocet_odpovedi >= @question.position
         # vyberova otazka
    		if @questionUpd.update_attributes(params[:question])
      		flash[:notice] = "Otázka #{@question.question} byla úspěšně přidána."
   	   	redirect_to :action => 'index'
  		   else
    		   @page_title = 'editace'
    		   render :action => 'edit'
  		   end
      elsif @question.question == ""
 		   @page_title = 'Nezada-li jste otázku.'
    		@question.id = params[:id]							# musi byt jinak to pri nacteni stranky haze chybu ze tam neni ID  
    		render :action => 'edit' 
  		else 
 		   @page_title = 'Číslo správné odpovědi (číslo řádku) nesmí byt větší jak počet řádků.'
    		@question.id = params[:id]  
    		render :action => 'edit'
      end  			
	end
	
	def destroy
  		@question = Question.find(params[:id])
  		flash[:notice] = "Otázku jsi úspěšně smazal #{@question.question}"
  		@question.destroy
  		redirect_to :action => 'index'
	end

	def show
  		@question = Question.find(params[:id])
  		@page_title = 'Otázka'
	end

  	def index
    	#@questions = Question.find(:all)
    	@questions = Question.find_by_sql("SELECT * FROM questions ORDER BY id DESC")
  		@page_title = 'Přehled otázek'
	end

end
