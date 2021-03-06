class CreateMachines < ActiveRecord::Migration
  
  def self.up
    create_table :machines do |t|
      t.string :ip, :limit => 15
      t.string :mac, :limit => 17
      t.string :distro
      t.string :template
      t.text :descr
    end
    Capability.create(:cap_code => "0-machine-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-machine-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-machine-X-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :machines
  end
  
end
