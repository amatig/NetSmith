require 'active_record'

class Users < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :minimum => 6
end
