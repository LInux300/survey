class CreateDokumenties < ActiveRecord::Migration
  def self.up
    create_table :dokumenties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :dokumenties
  end
end
