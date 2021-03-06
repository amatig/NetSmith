class CreateServers < ActiveRecord::Migration
  
  def self.up
    create_table :servers do |t|
      t.string :ip, :limit => 15
      t.string :conn_type, :limit => 15
      t.text :descr
    end
    Capability.create(:cap_code => "0-server-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-server-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-server-X-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :servers
  end
  
end
