class CreateSettingValues < ActiveRecord::Migration
  
  def self.up
    create_table :setting_values do |t|
      t.integer :machine_id
      t.string :name, :limit => 25
      t.string :value
    end
    Capability.create(:cap_code => "0-setting_value-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-setting_value-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-setting_value-X-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :setting_values
  end
  
end
