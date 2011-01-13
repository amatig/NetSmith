class CreateMachines < ActiveRecord::Migration
  
  def self.up
    create_table :machines do |t|
      t.string :ip, :limit => 15
      t.string :mac, :limit => 17
      t.string :hostname
      t.string :template
      t.text :descr
    end
  end
  
  def self.down
    drop_table :machines
  end
  
end
