class SettingValues < ActiveRecord::Base
  validates_presence_of :machines_id
  validates_presence_of :name 
  validates_presence_of :value
  belongs_to :machines
end
