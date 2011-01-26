class CreateDhcpOptionInstances < ActiveRecord::Migration
  def self.up
    create_table :dhcp_option_instances do |t|
      t.integer :dhcp_context_id
      t.integer :dhcp_option_id
      t.string :value
      t.text :descr
    end
    Capability.create(:cap_code => "0-dhcp_option_instance-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-dhcp_option_instance-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-dhcp_option_instance-X-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :dhcp_option_instances
  end
end
