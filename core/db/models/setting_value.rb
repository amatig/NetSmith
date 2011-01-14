class SettingValue < ActiveRecord::Base
  belongs_to :machine
  
  validates_presence_of :machine_id
  validates_presence_of :name 
  validates_presence_of :value
end
