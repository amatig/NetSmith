class CreateSettingValues < ActiveRecord::Migration
  
  def self.up
    create_table :setting_values do |t|
      t.integer :machines_id
      t.string :name, :limit => 25
      t.string :value
    end
  end
  
  def self.down
    drop_table :setting_values
  end
  
end
