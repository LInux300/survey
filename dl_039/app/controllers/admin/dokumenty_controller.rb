class Admin::DokumentyController < ApplicationController
	before_filter :login_required
	before_filter :check_editor_role    
								
  def index
     @dokuments = Dokument.find(:all)
  	  @page_title = 'Přehled dokumentů'
  	  @users = User.find(:all)
  end

  def ukazat
    @dokument = Dokument.find(params[:id])
  	 @page_title = "Název dokumentu: #{@dokument.nazev}"
  end

  def nahrat
		@page_title = 'Nahrát nový dokument.'  
  end
  
  def vytvor
    @dokument = Dokument.new(params[:dokument])
	 @dokument.user_id = session[:user]
    if request.post? and @dokument.save
   	flash[:notice] = "Dokument #{@dokument.nazev} byl úspěšně přidán."
    end      
    redirect_to :action => 'nahrat'
  end
  
  def uprav
  		@dokument = Dokument.find(params[:id])
 		@page_title = 'Úprava dokumentu: ' + @dokument.nazev 
  end

  def update__
  		@dokument = Dokument.find(params[:id])
  		if @dokument.update_attributes(params[:dokument])
    		flash[:notice] = 'Dokument "'  + @dokument.nazev  + '" byl úspěšně změněn.'
    		redirect_to :action => 'pozice', :id => @dokument
  		else
    		@page_title = 'Úprava dokumentu: ' + @dokument.nazev 
    		render :action => 'edit'
  		end
  end

  def destroy
  	   @dokument = Dokument.find(params[:id])
  		File.delete("#{RAILS_ROOT}/public/#{@dokument.nazev}") 
  		@dokument.destroy
  		redirect_to :action => 'index'
  		flash[:notice] = "Dokument se úspěšně smazal #{@dokument.nazev}"
  end
 
  def sepiatone
      @dokument = Dokument.find(params[:id])
      render_image @dokument.nazev do |img|
        img.sepiatone
      end
  end
    
  def render_image( file, options = {} )
       format = if options.is_a?(Hash) then options[:force_format] else nil end
       mime_type = if options.is_a?(String) then options else options[:mime_type] end
 		 # TODO: tohle jsem zakomentoval      
       #mime_type ||= file.mime_type
       path = if file.is_a?( String ) then file else file.path end
       headers["Content-Type"] = mime_type unless format 
 		 # TODO: tohle jsem zakomentoval      
       #if block_given? or format
       #  img = ::Magick::Image::read(path).first
       #  img = yield( img ) if block_given?
       #  img.format = format.to_s.upcase if format
       #  render :text => img.to_blob, :layout => false
       #else
         send_file( path )
       #end
  end
     
end
