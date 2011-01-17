class CreateUsers < ActiveRecord::Migration

  def self.up
    create_table :users do |t|
      t.string :username
      t.integer :userid
      t.text :descr
      t.text :key
    end
    Capability.create(:cap_code => "0-user-#{generate_cap}")
  end

  def self.down
    drop_table :users
  end
end
