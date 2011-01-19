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

module UserBackend
  
  def self.only_root()
    suser = UserBackend.get_signed_user
    if suser and not suser.is_superuser?
      raise "Use sudo or root for use this method"
    end
  end

  def self.only_your_or_root(username)
    user = Etc.getpwnam(username)
    if not (user.uid == Process.uid or Process.uid == 0)
      raise "You can't modify public key file for #{username} user, use root account"
    end
  end

  def self.get_signed_user
    User.find(:first, :conditions => ["userid=?", Process.uid])
  end

  def self.get_uid(username)
    Etc.getpwnam(username).uid
  rescue
    nil
  end
  #Questo metodo e' solo accessibile attraverso l'oggetto User
  def is_superuser?
    (self.userid==0)
  end

  #Questo e' un medoto di modulo
  def self.is_superuser?(user_name)
    user = Etc.getpwnam(user_name)
    (user.uid==0)
  end

end
