class Admin::Ankety::AnketaController < ApplicationController
	before_filter :login_required
	before_filter :check_editor_role    

   def new
   	load_data
	  	@anketa = Anketa.new
		@page_title = 'Vytvoření nové ankety'
   end

	def create
  		@anketa = Anketa.new(params[:anketa])
  		if @anketa.save
   		flash[:notice] = "Anketa #{@anketa.title} byla úspěšně přidána."
   		redirect_to :action => 'new'
  		else
    		@page_title = 'Vytvoření nové ankety'
    		render :action => 'new'
  		end
	end


	def edit
		load_data  		
  		@anketa = Anketa.find(params[:id])
 		@page_title = 'Úprava ankety: ' + @anketa.title 
	end

	def update
  		@anketa = Anketa.find(params[:id])
  		if @anketa.update_attributes(params[:anketa])
    		flash[:notice] = 'Anketa "'  + @anketa.title  + '" byla úspěšně změněna.'
    		redirect_to :action => 'pozice', :id => @anketa
  		else
    		@page_title = 'Úprava ankety: ' + @anketa.title 
    		render :action => 'edit'
  		end
	end

	def destroy
  	   @anketa = Anketa.find(params[:id])
  		flash[:notice] = "Anketu jsi úspěšně smazal #{@anketa.title}"
  		@anketa.destroy
  		redirect_to :action => 'index'
	end

	def show
  		@anketa = Anketa.find(params[:id])
  		loadQuestions
  		@skupina = Status.find(@anketa.status_id)
  		@page_title = 'Detail ankety: ' + @anketa.title
		# vypise seznam otazek
		#@anketaQuestions = AnketasQuestions.find(:all, :conditions => [question_id = params[:id]] ) # vraci IDs
		#@questions = [] 
		#for anketaQuestion in @anketaQuestions
		#	# ulozi do pole, jako v pythonu append			
		#	@questions << Question.find(:first, :conditions => [id = anketaQuestion.question_id.to_s ] )			
		#end	
	end

	def pozice
	
	   "
	     Vytvoreni poradi otazek v ankete, 
	   "  
	     
  		@anketa = Anketa.find(params[:id])
  		@page_title = 'Změna pozice otázek ankety: ' + @anketa.title
		#@anketaQuestions = AnketasQuestions.find(:all, :conditions => [question_id = params[:id]] ) # vraci IDs
		# TODO: mozna cisz z HTML pres formular --> ulehcit tak mysql servru!!!
		# TODO: predelat na poslani z formulare, abych mohl udelat update!!!
		loadQuestions
	end
	
   def createPozition
     
     "
       Zmeni poradi otazek v ankete.
     "     
  	  loadQuestions
     if params[:post][:otazka_zmena_pozice] != ""
       @poziceZmena = params[:post][:otazka_zmena_pozice].to_i
       @pozicePodle = params[:post][:otazka_podle_pozice].to_i
       if params[:anketas_questions] == "na_zacatek"
         # z formulare mi leze pozice otazky a ne id otazky, pozor na to !!!
         @novaPozice = 1
         for aq in @otazkyPozice 
           aq[:pozice_otazky] = aq[:pozice_otazky].to_i
           if @novaPozice <= aq[:pozice_otazky] and  @poziceZmena > aq[:pozice_otazky]   
              aq[:pozice_otazky] = aq[:pozice_otazky] + 1
           elsif @poziceZmena == aq[:pozice_otazky]
              # zmeni puvodni pozici na novou pozici 
              aq[:pozice_otazky] = @novaPozice 
           end
           # TODO: udelat jeden UPDATE, pomoci jedne query
           #@query += "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]}; "        
           sql = ActiveRecord::Base.connection();
   	     sql.update "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]; }"
         end
       elsif params[:anketas_questions] == "pred"        
         for aq in @otazkyPozice 
           aq[:pozice_otazky] = aq[:pozice_otazky].to_i
           if @pozicePodle > @poziceZmena
              if aq[:pozice_otazky] >  @poziceZmena and aq[:pozice_otazky] < @pozicePodle
                 aq[:pozice_otazky] = aq[:pozice_otazky] - 1
              elsif aq[:pozice_otazky] == @poziceZmena
                 aq[:pozice_otazky] = @pozicePodle -1
              end 
           elsif  @pozicePodle < @poziceZmena
              if aq[:pozice_otazky]>= @pozicePodle and aq[:pozice_otazky] < @poziceZmena
                 aq[:pozice_otazky] = aq[:pozice_otazky] + 1
              elsif aq[:pozice_otazky] == @poziceZmena
                 aq[:pozice_otazky] = @pozicePodle
              end
           end
           sql = ActiveRecord::Base.connection();
   	     sql.update "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]; }"
         end 
         elsif params[:anketas_questions] == "za"
          for aq in @otazkyPozice 
            aq[:pozice_otazky] = aq[:pozice_otazky].to_i
            if @pozicePodle > @poziceZmena
                if aq[:pozice_otazky] >  @poziceZmena and aq[:pozice_otazky] <= @pozicePodle
                   aq[:pozice_otazky] = aq[:pozice_otazky] - 1
                elsif aq[:pozice_otazky] == @poziceZmena
                   aq[:pozice_otazky] = @pozicePodle
                end 
            elsif  @pozicePodle < @poziceZmena
                if aq[:pozice_otazky] > @pozicePodle and aq[:pozice_otazky] < @poziceZmena
                   aq[:pozice_otazky] = aq[:pozice_otazky] + 1
                elsif aq[:pozice_otazky] == @poziceZmena
                   aq[:pozice_otazky] = @pozicePodle + 1 
                end
            end
            sql = ActiveRecord::Base.connection();
   	      sql.update "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]; }"
         end 
       elsif params[:anketas_questions] == "na_konec"
			 # zatim nejede        
#         @novaPozice = @pocetPrvku + 1
#         @otazkyPozice[@pocetPrvku]['pozice_otazky'] = @pocetPrvku

#         for aq in @otazkyPozice 
#           aq[:pozice_otazky] = aq[:pozice_otazky].to_i
           # ke vsem otazkem, ktere maji pozici mensi nez pozice nove otazky            
           #if aq[:pozice_otazky] == 0
           #   @posledniPozize = @posledniPozize + 1 
           #   aq[:pozice_otazky] = @posledniPozize
#           if @poziceZmena < aq[:pozice_otazky] and @novaPozice > aq[:pozice_otazky]
              # zmeni puvodni pozici na novou pozici 
#              aq[:pozice_otazky] = aq[:pozice_otazky] - 1     
#           elsif @novaPozice == aq[:pozice_otazky]
#             aq[:pozice_otazky] = @novaPozice
           #elsif @poziceZmena < aq[:pozice_otazky]    
           #   aq[:pozice_otazky] = aq[:pozice_otazky] - 1
#           end
           # TODO: udelat jeden UPDATE, pomoci query
           #@query += "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]}; "        
#           sql = ActiveRecord::Base.connection();
#   	     sql.update "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]; }"
#         end
       end
     end	       
     redirect_to :action => 'pozice', :id => params[:id]
   end
   
   def updateRecords_old
   
      '
          Update MySQL records(pozcice otazek v ankete) 
      '

         #@query = "" 
         for aq in @otazkyPozice 
           aq[:pozice_otazky] = aq[:pozice_otazky].to_i
           # ke vsem otazkem, ktere maji pozici mensi nez pozice nove otazky            
           #if aq[:pozice_otazky] == 0
           #   @posledniPozize = @posledniPozize + 1 
           #   aq[:pozice_otazky] = @posledniPozize
           if @novaPozice <= aq[:pozice_otazky] and  @poziceZmena > aq[:pozice_otazky]   
              aq[:pozice_otazky] = aq[:pozice_otazky] + 1
           elsif @poziceZmena == aq[:pozice_otazky]
              # zmeni puvodni pozici na novou pozici 
              aq[:pozice_otazky] = @novaPozice 
           end
           # TODO: udelat jeden UPDATE, pomoci query
           #@query += "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]}; "        
           sql = ActiveRecord::Base.connection();
   	     sql.update "UPDATE anketas_questions SET question_position = #{aq[:pozice_otazky]} WHERE anketa_id = #{aq[:anketa_id]} AND question_id = #{aq[:otazka_id]; }"
         end
         # TODO:         
         #sql = ActiveRecord::Base.connection();
	      #ActiveRecord::ConnectionAdapters::DatabaseStatements.execute(@query)
   end

   def loadQuestions
   
      '      
        Jako vstup je params[:id]  --> ID ankety. Slouzi k nacteni otazek pro danou anketu      
      '
      
		@otazkyPozice = AnketasQuestions.find_by_sql("SELECT questions.id as otazka_id, questions.question AS otazka,
		 anketas.id AS anketa_id, anketas.title as nazev_ankety, anketas_questions.question_position as pozice_otazky 
		 FROM anketas, questions, anketas_questions WHERE questions.id = anketas_questions.question_id and 
		  anketas.id = #{params[:id]} and anketas_questions.anketa_id =  #{params[:id]} ORDER BY anketas_questions.question_position ASC")
		# if probehne jen poprve kdyz nejsou nastaveny otazky
       zmenaPoctuOtazek
   end
   
   def zmenaPoctuOtazek
      '      
      # nastavi poradi otazek v ankete, kdyz pridam nebo odeberu otazku, nebo-li pri zmene poctu otazek v ankete
      '      

      @pocetPrvku = @otazkyPozice.size - 1
      if @pocetPrvku != @otazkyPozice[@pocetPrvku]['pozice_otazky'].to_i  - 1    
		#if @otazkyPozice[0]['pozice_otazky'].to_i == 0
			for otazkyPoz in @otazkyPozice
		   	pozice = 1 + pozice.to_i
		   	otazkyPoz.pozice_otazky = pozice
			end   
		end  
   
   end
   
  	def index
    	@anketas = Anketa.find(:all)
  		@page_title = 'Přehled anket'
	end

	def load_data
  		@questions = Question.find(:all)
  		@statuses = Status.find(:all)
	end

end
