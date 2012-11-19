class AnketyController < ApplicationController
	
	# obsluhuje ankety pro uzivatele

  	def seznam

		"
			zobrazi seznam vsech anket 
		"

    	@anketas = Anketa.find(:all)
  		@page_title = 'Přehled anket'
	end

	def anketa

		"
			zobrazi anketu kterou si vybral uzivatel 
		"

  		@anketa = Anketa.find(params[:id])
  		@params = params[:id]				# id ankety
		# vraci jen IDs
		@anketaQuestions = AnketasQuestions.find(:all, :conditions => [  "anketa_id =  #{@params}" ], :order => "question_position ASC" ) # vraci IDs
		@questions = [] 
		for anketaQuestion in @anketaQuestions
			# ulozi do pole, jako v pythonu append			
			@questions << Question.find(:first, :conditions => [ "id = #{anketaQuestion.question_id}" ] )			
		end
	end


	def create

		"
			vytvori tolik zaznamu v tabulce kolik je otazek v ankete
			hodnoceni = jedne otazce z ankety 
		"
		# TODO: ulozi dvakrat jestlize ve formulari kliknu dvakrat po sobe rychle na mys
		# TODO: mozna to cely dat do vyjimky, usetrim tak celkovou chybu, kdyz zpatne sql , aplikace ...
		lastSessionRecord
		hodnoceniCeleAnkety		
		getUserID
  		@length = params[:hodnoceni].length
		@length = @length -1
		@celkem_znamky = 0		
  		for i in 0..@length 
	  		@hodnoceni = Hodnoceni.new(params[:hodnoceni][i])
	  		@hodnoceni['session_id'] = @lastSessionID 	  	 	  
	  		@hodnoceni['user_id'] = @userID  	
	  		@hodnoceni['podpis'] = params[:podpis]
	  		if params[:znamka]   # tohle podminka je tady protoze jsou dva typy otazek, zakladni a otazky z odpovedima	
	  			@hodnoceni['znamka'] = params[:znamka]
	  		end	 	
	  		@celkem_znamky = @celkem_znamky + @hodnoceni['znamka']   			
			fetch_value_Question
         vyberoveOtazky
  			if @hodnoceni.save
  			else
    			@page_title = 'hodnocení se nepodařilo uložit, zkuste znovu'
    			# render :action => 'anketa'
    			# todo: ZASTAVIM FOR CYKLUS, JINAK TO SPADNE !!!
    		end	 
  		end
		fetch_value_Anketa
  		flash[:notice] = "Hodnocení bylo úspěšně přidáno."
		redirect_to :action => 'seznam'
	end

	def typy
		@typs = Status.find(:all)
	end

	def typ
		@typ = Status.find(params[:id])
    	@anketas = Anketa.find(:all, :conditions => ["status_id = #{@typ.id} "], :order => "title")
	end

   
private

   def vyberoveOtazky
   
			"
			osetri kdyz prijde vyberova otazka
			"
        
         if params[:"#{@hodnoceni['question_id']}"]
         	@vyberovaOtazkys = @hodnoceni['user_body'].split("\r\n")	  		
            @hodnoceni['hodnota_odpovedi'] = params[:"#{@hodnoceni['question_id']}"] # je to cislo
            @poziceOdpovedi = params[:"#{@hodnoceni['question_id']}"].to_i  - 1
            @hodnoceni['user_body'] = @vyberovaOtazkys[@poziceOdpovedi]  # ulozim hodnotu odpovedi
            # position je z fetch_value_Question promenna
            if @positionD.to_i == 0
					@hodnoceni['hodnota_spravne'] = "BEZ"             				
				elsif @positionD == @hodnoceni['hodnota_odpovedi'] 
					@hodnoceni['hodnota_spravne'] = "ANO" 
				else
					@hodnoceni['hodnota_spravne'] = "NE" 
				end
			else			   
					@hodnoceni['hodnota_spravne'] = "-"
			end	    
   end
   
	def lastSessionRecord 
		
		"
			z tabulky vezme posledni zaznam z pole session_id, je to vyplnena anketa a vsechny otazky ktere poslal uzivatel
		"

  		@lastRecord = Hodnoceni.find_by_sql(" SELECT session_id FROM hodnocenis ORDER BY session_id DESC LIMIT 1")
		if @lastRecord.length == 0				# potencionalni nebezpecny kod	
			# zavolase se jen v pripade kdyz v databazi neni zadnej zaznam			
			@lastSessionID = 1
		else
			@lastSessionID = @lastRecord[0].session_id  + 1
		end
	end

	def hodnoceniCeleAnkety
	
		"
			secteni vsech hodnoceni u vsech otazek a pocet otazek, 
		"

		@hodnoceniVsechOtazekAnkety = 0 											# TODO: pridava hodnoty do tabulky ankety
		@pocetVsechOtazekAnkety = 0 											# TODO: pridava hodnoty do tabulky ankety	
	end
	
	def getUserID
	
		"
			zjisti aktualniho uzivatele 
		"
		if session[:user]
			@userID = session[:user]
		else
			@userID = 0
		end
	end
		

	def fetch_value_Question	 
	
		"
			jako vstup je id otazky, a znamka kterou poslal uzivatel u konkrektni otazky			
			aktualizuje otazku, provede se bezpecne pomoci transakce na DB 
		"
		# TODO: at se aktualizuje i pole updated_at
		sql = ActiveRecord::Base.connection();
		sql.execute "SET autocommit=0";
		sql.begin_db_transaction
		votes_total, mark_total, @positionD =
		sql.execute("SELECT votes_total, mark_total, position FROM questions WHERE id = #{@hodnoceni['question_id']} LIMIT 1 FOR UPDATE").fetch_row;
		sql.update "UPDATE questions SET mark_total = mark_total + #{@hodnoceni['znamka']}, votes_total = 	votes_total + 1 WHERE id = #{@hodnoceni['question_id']};"; 
		sql.commit_db_transaction 
		mark_total;
	end

	def fetch_value_Anketa	
	
		"
			vola jej funkce create			
			jako vstup parametry:  @length + 1  = 'secteni vsech otazek'; @celkem_znamky = 'sectene znamek u vsech otazek'
			aktualizuje anketu, provede se bezpecne pomoci transakce na DB 
		"

		# TODO: at se aktualizuje i pole updated_at
		sql = ActiveRecord::Base.connection();
		sql.execute "SET autocommit=0";
		sql.begin_db_transaction
		votes_total, mark_total =
		sql.execute("SELECT votes_total, mark_total FROM anketas WHERE id = #{@hodnoceni['anketa_id']} LIMIT 1 FOR UPDATE").fetch_row;
		sql.update "UPDATE anketas SET mark_total = mark_total + #{@celkem_znamky}, votes_total = votes_total + #{@length} + 1 WHERE id = #{@hodnoceni['anketa_id']};"; 
		sql.commit_db_transaction 
		mark_total;
	end
	
end
