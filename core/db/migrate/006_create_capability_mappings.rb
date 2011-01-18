class CreateCapabilityMappings < ActiveRecord::Migration
  
  def self.up
    create_table :capability_mappings do |t|
      t.integer :user_id
      t.string :rand_code
    end
  end
  
  def self.down
    drop_table :capability_mappings
  end
  
end
