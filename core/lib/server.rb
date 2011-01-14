class ServerLib
  
  def add(ip, conn_type, hostname, descr)
    s = Server.new(:ip => ip, 
                    :conn_type => conn_type,
                    :hostname => hostname,
                    :descr => descr)
    if s.valid?
      s.save
    else
      s.errors
    end
  end
  
  def del(ip)
    s = Server.find(:first, :conditions => ["ip = ?", ip])
    if s
      s.destroy
      true
    else
      "Server #{ip} not found"
    end
  end
  
  def edit(ip, attr, value)
    s = Server.find(:first, :conditions => ["ip = ?", ip])
    if s
      s[attr] = value
      if s.valid?
        s.save
      else
        s.errors
      end
    else
      "Server #{ip} not found"
    end
  end
  
  def list
    Server.all
  end
  
end
