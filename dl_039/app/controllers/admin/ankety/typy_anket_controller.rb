class Admin::Ankety::TypyAnketController < ApplicationController
	before_filter :login_required
	before_filter :check_editor_role    

  def new
		@page_title="Přidat nový anketní typ"
  end

  def create
  		@typ = Status.new(params[:typ])
  		if @typ.save
   		flash[:notice] = "Typ #{@typ.name} byl úspěšně přidán."
   		redirect_to :action => 'index'
  		else
    		@page_title = 'Vytvoření nového typu'
    		render :action => 'new'
  		end
  end

  def edit
		@typ = Status.find(params[:id])
		@page_title="úprava skupiny typu #{@typ.name}"
  end

  def update
  		@typ = Status.find(params[:id]) 
  		if @typ.update_attributes(params[:typ])
    		flash[:notice] = 'Typ jsi úspěšně změnil'
    		redirect_to :action => 'ukazat', :id => @typ
  		else
    		@page_title = 'edituj typ'
    		render :action => 'edit'
  		end
  end 

  def destroy
  		@typ = Status.find(params[:id])
  		flash[:notice] = "Typ jsi úspěšně smazal #{@typ.name}"
  		@typ.destroy
  		redirect_to :action => 'index'  
  end

  def ukazat
		@typ = Status.find(params[:id])
  end

  def index
  		redirect_to :action => 'typy'
  end


	def typy
		@page_title="správa anketních typů"
		@typy = Status.find(:all)
	end

	def typ
		@typ = Status.find(params[:id])
    	@anketas = Anketa.find(:all, :conditions => ["status_id = #{@typ.id} "], :order => "title")
	end


end
