require 'digest/sha2'
class User < ActiveRecord::Base
   #protected		# TODO: tohle bych mel asi udelat vsude, na strankach knihoven rails to tak maji 
	validates_size_of :fotka, :allow_nil => true, :maximum => 200000, :message => " je moc velká, musí byt menší jak 200kB!"
	
	#image_column :fotka
	#upload_column :fotka, :versions => [ :thumb, :large ]
	#upload_column :fotka, :old_files => :delete
	upload_column :fotka, :store_dir => proc{|record, file| "uzivatel/fotka/#{record.id}"}

	attr_protected :hashed_password, :enabled
	attr_accessor :password  

 	# vytvoreni prazdneho moduelu, je to prazndy objekt, jeste nez je vytvorena z databaze  78/53 je to popsano nahore na strance
 	
	has_and_belongs_to_many :roles	
	has_many :hodnocenis
	has_many :dokuments
	
	validates_presence_of :username, :message => " / Uživatelské Jméno nemůže být prázdné."
	validates_presence_of :email, :message => " / E-mail nemůže být prázdný."
	#validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message => " / email je neplatný." 
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => " / email je neplatný." 
	validates_presence_of :password, :if => :password_required?, :message => " / Heslo nemůže být prázdné."
	validates_presence_of :password_confirmation, :if => :password_required?, :message => " / Heslo znovu nemůže být prázdné."
	#validates_presence_of :profile
	#validates_presence_of :name
 	#validates_presence_of :phone
	#validates_presence_of :address
	#validates_presence_of :city
	#validates_presence_of :postcode
	#validates_presence_of :country
 

	validates_confirmation_of :password, :if => :password_required?, :message => " / Heslo k potvrzení nemůže být prázdné."
	
	validates_uniqueness_of :username, :case_sensitive => false, :message => " / Uživatelské Jméno - zvolit si jiné uživatelské jméno."
	validates_uniqueness_of :email, :case_sensitive => false, :message => " / E-mail - zvolit si jiný email."

	validates_length_of :username, :within => 5..23, :too_short => " / Uživatelské Jméno je krátké minimum (5 znaků).", :too_long => " / Uživatelské jméno je příliž dlouhé, zvolte kratší."
	validates_length_of :email, :within => 5..128 , :too_short => " / E-mail je krátký.", :too_long => " / E-mail je příliž dlouhý."
	validates_length_of :password, :within => 4..20, :if => :password_required? , :too_long => " / Heslo je příliž dlouhé.", :too_short => " / Heslo je příliž krátké."
	#validates_length_of :profile, :maximum => 1000
 
	def before_save
		self.hashed_password = User.encrypt(password) if !self.password.blank?
	end	
	
	def password_required?
		self.hashed_password.blank? || !self.password.blank?
	end
 	
	def self.encrypt(string)
		return Digest::SHA256.hexdigest(string)
	end
	
	# 78/53
	def self.authenticate(username,password)  
		find_by_username_and_hashed_password_and_enabled(username, User.encrypt(password), true)
	end
 	
	#99 this method gives us an easy way of checking if a user object instance has a particular role or not. check if a user has been given the administrator role with  user.has_role?('Administrator')
	

	def has_role?(rolename) 
		self.roles.find_by_name(rolename) ? true : false
	end

	
	# TODO: tohle je pro studijni ucely muzu pridavat chyby nejak globalneji, namet ke <STUDIUM>
   #   def validate
        #errors.add_on_empty %w( first_name last_name )
        #errors.add("phone_number", "has invalid format") unless phone_number =~ /[0-9]*/
        #errors.add("username", "hasddd invalid format")#unless username =~ /[0-9]*/
   #   end

   #   def validate_on_create # is only run the first time a new object is saved
        #unless valid_discount?(membership_discount)
          #errors.add("membership_discount", "has expired")
        #end
   #   end

   #   def validate_on_update
        #errors.add_to_base("No changes have occurred") if unchanged_attributes?
   #   end
	#  </STUDIUM>
	
end
