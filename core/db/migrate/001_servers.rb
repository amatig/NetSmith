require 'active_record'

class Servers < ActiveRecord::Migration
  
  def self.up
    create_table :servers do |t|
      t.string :ip, :limit => 15
      t.string :hostname
      t.string :mac, :limit => 17
      t.string :conn_type, :limit => 15
      t.text :descr
    end
  end
  
  def self.down
    drop_table :servers
  end
  
end
