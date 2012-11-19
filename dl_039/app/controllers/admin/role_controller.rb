class Admin::RoleController < ApplicationController
	before_filter :login_required
	before_filter :check_administrator_role
 	before_filter :check_superuser_role, :only => [:destroy, :update]
	
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
  	 @page_title = "Seznam skupin"
    @roles = Role.find(:all)
  end

  def show
  	@page_title = 'Skupina'
    @role = Role.find(params[:id])
  end

  def new
  	@page_title = "Nová skupina"
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      flash[:notice] = 'Nová skupina byla úspěšně vytvořena.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
  	@page_title = "Editace skupiny"
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      flash[:notice] = 'Skupina byla úspěšně změněna.'
      redirect_to :action => 'show', :id => @role
    else
      render :action => 'edit'
    end
  end
 
  def destroy
    Role.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
