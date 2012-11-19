class CreateStatuses < ActiveRecord::Migration
  	
  	def self.up
  		create_table :statuses do |table|
    		table.column :name, :string, :limit => 255, :null => false, :unique => true
    	end	
  	end

  	def self.down
		drop_table :statuses  	
  	end
end
