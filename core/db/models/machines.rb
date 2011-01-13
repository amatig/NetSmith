class Machines < ActiveRecord::Base
  validates :ip, :mac, :presence => true
  validates_format_of :ip, :with => /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  validates_format_of :mac, :with => /^[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}$/
  validates :ip, :mac, :uniqueness => true
  
  def to_s
    return "#{ip}\t#{mac}\t#{hostname}\t#{template}\t#{descr}"
  end
  
end
