class Server
  
  def self.add(conn_type, ip, hostname, descr)
    s = Servers.new(:conn_type => conn_type,
                    :ip => ip, 
                    :hostname => hostname,
                    :descr => descr)
    if s.valid?
      s.save
    else
      format_err(s.errors)
    end
  end
  
  def self.del(ip)
    s = Servers.find(:first, :conditions => ["ip = ?", ip])
    if s
      s.delete
      true
    else
      "Server not found"
    end
  end
  
  def self.edit(ip, attr, value)
    s = Servers.find(:first, :conditions => ["ip = ?", ip])
    if s
      s[attr] = value
      if s.valid?
        s.save
      else
        format_err(s.errors)
      end
    else
      "Server not found"
    end
  end
  
  def self.list
    Servers.all
  end
  
end
