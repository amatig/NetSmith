class CreateUsers < ActiveRecord::Migration
  
  def self.up
    create_table :users do |t|
      t.string :username
      t.integer :userid
      t.text :sslkey
      t.text :descr
    end
    Capability.create(:cap_code => "0-user-#{LibCapability.generate_cap}")
  end
  
  def self.down
    drop_table :users
  end
  
end
