class UsersController < ApplicationController
	before_filter :login_required, :except => [:new, :create]  
   before_filter :check_administrator_role, :only => [:index, :destroy, :enable, :adminshow]
   before_filter :check_superuser_role, :only => [:index, :destroy, :enable, :adminshow]

  def index
   	@users = User.find(:all)
  end

  def show
  	@user = User.find(session[:user])
  end

  def podrobnosti
  	@user = User.find(session[:user])
  end
	
  def show_by_username
  	@user = User.find_by_username(params[:username])
  	render :action => 'show'
  end

  def new
  	@user = User.new
  end
  def create
  	@user = User.new(params[:user])
  	if @user.save
  		self.logged_in_user = @user
  		#redirect_to index_url
  		redirect_to :controller => '/users', :action => 'show', :id => session[:user]
  		flash[:notice] = 'Účet byl vytvořen.'
  	else
  		render :action => 'new'
  	end		
  end

  def edit
  	@user = logged_in_user
  end

  def update
  	@user = User.find(logged_in_user)
  	if @user.update_attributes(params[:user])
  		redirect_to :action => 'show', :id => logged_in_user
  		flash[:notice] = 'Uživatel byl aktualizován.'
  	else
  		render :action => 'edit'
  	end		
  end

  def destroy
  	@user = User.find(params[:id])
  	if @user.update_attribute(:enabled, false)
  		flash[:notice] = 'Uživatel deaktivován.'
  	else
  		flash[:error] = 'Byl problém s deaktivováním.'
  	end
  	redirect_to :action => 'index'	
  end

  def enable
  	@user = User.find(params[:id])
  	if @user.update_attribute(:enabled, true)
  		flash[:notice] = 'Uživatel aktivován'
  	else
  		flash[:error] = 'Byl problém s aktivováním uživatele.'
  	end
  	redirect_to :action => 'index'		
  end
end
