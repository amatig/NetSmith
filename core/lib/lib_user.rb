# Classe per la gestione degli utenti.
# = Description
# Questa classe si occupa della gestione degli utenti.
# = License
# NetSmith - bla bla bla
#
# Copyright (C) 2011 Giovanni Amati, Domenico Chierico
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
# = Authors
# Giovanni Amati, Domenico Chierico

class LibUser
 
  # Aggiungere un nuovo utente.
  
  def add(username, keyfile)
    if Process.uid!=0
      return "use sudo or root for adding new user"
    end
    if(not File.exist?(keyfile.to_s))
      return "File _#{keyfile}_ don't exists"
    end
    sslf = File.open(keyfile,"r")
    sslpkey = sslf.read
    sslf.close
    user = Etc.getpwnam(username)

    if user
      u = User.new(:username => user.name,
                   :userid => user.uid,
                   :sslkey => sslpkey)
      if u.valid?
        u.save
      else
        u.errors
      end
    else
      "User #{username} don't exists"
    end
  rescue Exception => detail
    p detail
  end

  def del(username)
    if Process.uid!=0
      return "user sudo or root for delete user"
    end
    user = Etc.getpwnam(username)
    u = User.find(:first, :conditions => ["username=? and userid=?", user.name, user.uid])
    if u
      u.destroy
    else
      "User #{username} do not exists"
    end
  end
  
  def list()
    User.all
  end
  
  def update_ssl_key(username, keyfile)
    user = Etc.getpwnam(username)
    if user.uid == Process.uid or Process.uid == 0
      if( not File.exist?(keyfile))
        return "File #{keyfile} don't exists"
      end
      sslpkey = File.open(keyfile,"r").read
      u = User.find(:first, :conditions => ["username=? and userid=?", user.name, user.uid])
      if u
        u[:sslkey] = sslpkey
        u.save
      else
        "Can't find #{username} into the system"
      end
    else
      "You can't modify public key file for #{username} user, use root account"
    end
  end
  
  def add_access_to(username, server_ip)
    user = Etc.getpwnam(username)
    u = User.find(:first, 
                  :conditions => ["username=? and userid=?", 
                                  user.name, 
                                  user.uid])
    if not u
      return "User #{username} doesn't exists"
    end
    s = Server.find(:first, :conditions => ["ip=?",server_ip])
    if not s
      return "No such server defined with this ip #{server_ip}"
    end
    cap = LibCapability.find_cap_code(s.id,s.class.to_s.downcase)
    if not cap
      return "No such capability for server #{server_ip}"
    end
    LibCapability.add_map(u,cap.cap_code)
  end
  
  def list_capability()
    uid = Process.uid
    u = User.find(:first, :conditions => [ "userid=?", uid])
    if not u
      user = Etc.getpwid(uid)
      return "User #{user.name} isn't added tu NetSmith"
    end
    u.capability_mappings
  end
  
end
