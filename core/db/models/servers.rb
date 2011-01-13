class Servers < ActiveRecord::Base
  validates :ip, :conn_type, :presence => true
  validates_format_of :ip, :with => /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  validates_length_of :conn_type, :maximum => 15
  validates :ip, :uniqueness => true
  
  def to_s
    return "#{ip}\t#{conn_type}\t#{hostname}\t#{descr}"
  end
  
end
