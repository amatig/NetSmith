class CreateCapabilities < ActiveRecord::Migration
  def self.up
    create_table :capabilities do |t|
      t.string :cap_code
    end
  end

  def self.down
    drop_table :capabilities
  end
end
