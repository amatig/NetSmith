# Modulo per la gestione degli utenti.
# = Description
# Questo modulo si occupa della gestione degli utenti.
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

module LibUser
  
  # Aggiungere una nuova utente.
  def LibUser.add(username, keyfile)
    LibCapability.require_cap(0,"user","W")
    if (not File.exist?(keyfile))
      return "File #{keyfile} don't exists"
    end
    sslpkey = IO.read(keyfile).strip()
    user_id = UserBackend.get_uid(username)
    
    if user_id
      User.create!(:username => username,
                   :userid => user_id,
                   :sslkey => sslpkey)
    else
      "User #{username} don't exists"
    end
  rescue ActiveRecord::RecordInvalid => invalid
    invalid.record.errors
  end
  
  def LibUser.del(username)
    LibCapability.only_root
    User.find(:first, 
              :conditions => ["username=? and userid=?", 
                              username, 
                              UserBackend.get_uid(username)]).destroy
  rescue NoMethodError => method
    if method.name == :destroy
      return "User #{username} do not exists"
    else
      raise method
    end
  end
  
  def LibUser.list
    User.all
  end
  
  def LibUser.update_ssl_key(username, keyfile)
    LibCapability.only_your_or_root(username)
    if( not File.exist?(keyfile))
      return "File #{keyfile} don't exists"
    end
    sslpkey = File.open(keyfile,"r").read
    u = User.find(:first, 
                  :conditions => ["username=? and userid=?", 
                                  username,
                                  UserBackend.get_uid(username)])
    if u
      u[:sslkey] = sslpkey
        u.save
    else
      "Can't find #{username} into the system"
    end
  end
  
  def LibUser.add_access_to(username, server_ip)
    u = User.find(:first, 
                  :conditions => ["username=? and userid=?", 
                                  username, 
                                  UserBackend.get_uid(username)])
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
  
  def LibUser.list_capabilities
    LibCapability.require_cap(0,"capability_mapping","R")
    u = UserBackend.get_signed_user
    if not u
      user = LibBackend.get_singed_uname
      return "User #{user.name} isn't added tu NetSmith"
    end
    u.capability_mappings
  end
  
end
