require 'active_record'

class Prova < ActiveRecord::Migration
  
  def self.up
    create_table :prova do |t|
      t.string :name
      t.string :password
    end
  end
  
  def self.down
    drop_table :prova
  end
  
end
