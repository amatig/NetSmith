require 'active_record'

class Servers < ActiveRecord::Base
  validates :ip, :conn_type, :presence => true
  validates_length_of :conn_type, :maximum => 15
  # validates_format_of :conn_type, :with => /^local|ssh$/
  validates_format_of :ip, :with => /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  validates_format_of :mac, :with => /^[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}$/
  validates :ip, :uniqueness => true
end
