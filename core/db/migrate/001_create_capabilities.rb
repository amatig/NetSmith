class CreateCapabilities < ActiveRecord::Migration
  
  def self.up
    create_table :capabilities do |t|
      t.string :cap_code
    end
    Capability.create(:cap_code => "0-capability-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-capability-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-capability-X-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :capabilities
  end
  
end
