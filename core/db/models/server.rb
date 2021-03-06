class Server < NsBase
  validates_presence_of :ip
  validates_presence_of :conn_type
  validates_format_of :ip, :with => /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/
  validates_length_of :conn_type, :maximum => 15
  validates_uniqueness_of :ip
  
  def to_s
    return "#{id})\t#{ip}\t#{conn_type}\t#{descr}"
  end
  
end
