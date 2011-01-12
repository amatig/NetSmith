require "core/lib/database"
require "core/lib/utils"

class Server
  
  def self.add(conn_type, ip, hostname, descr)
    Database.enviroment
    s = Servers.new(:conn_type => conn_type,
                    :ip => ip, 
                    :hostname => hostname,
                    :descr => descr)
    if s.valid?
      s.save
    else
      puts format_err(s.errors)
    end
  end
  
  def self.del(ip)
    Database.enviroment
    s = Servers.find(:first, :conditions => ["ip = ?", ip])
    if s
      s.delete
    else
      puts "Server not found"
    end
  end
  
  def self.edit(ip, attr, value)
    Database.enviroment
    s = Servers.find(:first, :conditions => ["ip = ?", ip])
    if s
      s[attr] = value
      if s.valid?
        s.save
      else
        puts format_err(s.errors)
      end
    else
      puts "Server not found"
    end
  end
  
  def self.list
    Database.enviroment
    puts Servers.all
  end
  
end
