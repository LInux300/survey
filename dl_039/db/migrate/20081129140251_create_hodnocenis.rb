class CreateHodnocenis < ActiveRecord::Migration
  def self.up
    create_table :hodnocenis do |t|
      t.column :znamka, :integer
      t.column :user_id, :integer 
      t.column :user_body, :string
      t.column :anketa_id, :integer
      t.column :question_id, :integer
      t.column :session_id, :integer
      t.column :podpis, :string
      t.column :updated_at, :datetime      
      t.timestamps
    end
  end

  def self.down
    drop_table :hodnocenis
  end
end
