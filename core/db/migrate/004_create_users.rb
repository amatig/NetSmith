class CreateUsers < ActiveRecord::Migration
  
  def self.up
    create_table :users do |t|
      t.string :username
      t.integer :userid
      t.text :sslkey
    end
    Capability.create(:cap_code => "0-user-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-user-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-user-X-#{LibCapability.generate_cap}")
    User.create(:username => "root" , :userid => 0, :sslkey => "clean stuff")
  end
  
  def self.down
    drop_table :users
  end
  
end
