class CreateCapabilityMappings < ActiveRecord::Migration
  
  def self.up
    create_table :capability_mappings do |t|
      t.integer :user_id
      t.string :rand_code
    end
    Capability.create(:cap_code => "0-capability_mapping-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-capability_mapping-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-capability_mapping-X-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :capability_mappings
  end
  
end
