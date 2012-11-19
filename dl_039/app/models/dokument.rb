class Dokument < ActiveRecord::Base
	upload_column :nazev, :store_dir => "dokumenty/nazev"
	validates_size_of :nazev, :maximum => 2000000, :message => " je moc velká, musí byt menší jak 2000kB!"
	belongs_to :user	

end

