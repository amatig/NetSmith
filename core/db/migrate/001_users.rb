require 'active_record'

class Users < ActiveRecord::Migration
  
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :cell, :limit => 15
    end
  end
  
  def self.down
    drop_table :users
  end
  
end
