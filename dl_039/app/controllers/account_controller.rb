class AccountController < ApplicationController

  def authenticate
  	self.logged_in_user = User.authenticate(params[:user][:username],
  			params[:user][:password])
  	if is_logged_in?
  		flash[:notice]  = 'Úspěšné přihlášení'
  		redirect_to :controller => "users", :action => "show", :id => "#{session[:user]}"
  	else
  		flash[:error] = "Je mi líto uživatelské jméno, nebo heslo nebylo správně."
  		redirect_to :action => 'login'
  	end	 	
  end

  def logout
  	if request.post?
  		reset_session 
  		session[:user] = nil
				  	if is_logged_in?
  			  	else
  		flash[:notice] = 'Úspěšné odhlášení ze systému.'
  			  	end		
  	end
    session[:user] = nil
    cookies.delete :is_admin
  end   

end
