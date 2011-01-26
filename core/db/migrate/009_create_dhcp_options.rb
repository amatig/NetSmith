class CreateDhcpOptions < ActiveRecord::Migration
  def self.up
    create_table :dhcp_options do |t|
      t.string :name
      t.string :value
      t.integer :o_scope   #option, static
      t.text :descr
    end
    Capability.create(:cap_code => "0-dhcp_option-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-dhcp_option-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-dhcp_option-X-#{LibCapability.generate_cap}")
  end

  def self.down
    drop_table :dhcp_options
  end
end
