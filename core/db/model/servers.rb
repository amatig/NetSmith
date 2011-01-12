require "active_record"

class Servers < ActiveRecord::Base
  validates :conn_type, :ip, :presence => true
  validates_length_of :conn_type, :maximum => 15
  validates_format_of :ip, :with => /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  validates :ip, :uniqueness => true
  
  def to_s
    return "#{conn_type}\t#{ip}\t#{hostname}\t#{descr}"
  end
  
end
