class Machine < ActiveRecord::Base
  has_many :setting_values, :dependent => :destroy
  
  validates_presence_of :ip
  validates_presence_of:mac
  validates_format_of :ip, :with => /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  validates_format_of :mac, :with => /^[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}\:[0-9A-F]{2}$/
  validates_uniqueness_of :ip
  validates_uniqueness_of :mac
  
  def to_s
    return "#{ip}\t#{mac}\t#{hostname}\t#{template}\t#{descr}"
  end
  
end