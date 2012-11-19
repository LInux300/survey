class Admin::UsersController < Admin::BaseController
	before_filter :login_required
	before_filter :check_administrator_role
 	
#User.content_columns.each do |column|
# 	in_place_edit_for :user, column.user
#end
  
  def show
    @user = User.find(params[:id])
    @page_title = @author.name
  end

  def index
    @users = User.find(:all)
    @page_title = 'Seznam uživatelů'
  end

  def show
    @user = User.find(params[:id])
    @useSession = User.find_by_id(session[:user])
    if  @user.username != "Admin"
  	    @page_title = "#{@user.username}"
  	 else
  	    @page_title = "Zpátky"
  	 end   
  end

  def new
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash[:notice] = 'Uživatel byl úspěšně přidán.'
      redirect_to :action => 'index'
    end      
  end

  def edit
    @useSession = User.find_by_id(session[:user]) 
    @user = User.find(params[:id])
    @user.attributes = params[:user]
    if request.post? and @user.save
      flash[:notice] = 'Uživatel byl úspěšně změněn.'
      redirect_to :action => 'edit', :id => @user.id
    end      
    @user.password = @user.password_confirmation =  ''
    if  @user.username != "Admin"
  	 @page_title = "Úprava uživatele: #{@user.username}"
  	 else
  	    @page_title = "Zpátky"
  	 end   
  end
  
  def destroy
    if params[:id] != session[:user] and params[:id] != 1 
	    User.find(params[:id]).destroy
   	 redirect_to :action => 'index'
    end	 
  end
  
  def destroy_TODO_nevim_ted
  # mel jsem to u BOOK storu u uzivatelu, tu co jsem napsal destroy je obyc
    @user = User.find(params[:id])
    if request.post?
      @user.destroy
      flash[:notice] = 'Uživatel byl úspěšně smazán.'
      render :action => 'index'           
    end
  end
  
end
