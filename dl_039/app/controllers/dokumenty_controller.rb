class DokumentyController < ApplicationController
  before_filter :login_required
  def index
     @dokuments = Dokument.find(:all)
  	  @page_title = 'Přehled dokumentů'
  	  @users = User.find(:all)
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
