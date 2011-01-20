class CreateGroupsCapabilityMappings < ActiveRecord::Migration
  
  def self.up
    create_table :groups_capability_mappings do |t|
      t.integer :code
      t.string :rand_code
    end
    Capability.create(:cap_code => "0-groups_capability_mapping-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-groups_capability_mapping-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-groups_capability_mapping-X-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :groups_capability_mappings
  end
  
end
