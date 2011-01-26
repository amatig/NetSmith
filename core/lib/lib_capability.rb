# Modulo per la gestione delle capabilities.
# = Description
# Questo modulo si occupano della gestione delle capabilities per il controllo degli accessi alle risorse.
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

module LibCapability
  
  # Callback per generare una capability dopo ogni creazione di una entita'.
  def LibCapability.after_create(e)
    Capability.create(:cap_code => "#{e.id}-#{e.class.to_s.downcase}-R-#{generate_cap}")
    Capability.create(:cap_code => "#{e.id}-#{e.class.to_s.downcase}-W-#{generate_cap}")
    Capability.create(:cap_code => "#{e.id}-#{e.class.to_s.downcase}-X-#{generate_cap}")
  end
  
  # Random di 20 cifre per i codici di capabilities.
  # @return [String] numero di 20 cifre random.
  def LibCapability.generate_cap
    (0...20).collect { rand(10) }.join 
  end
  
  # Compone codici di capabily.
  # @param [Integer] id chiave univoca dell'entita' della tabella.
  # @param [String] tab nome della tabella.
  # @param [String/Integer] cap numero random.
  # @return [String] codice di capability.
  def LibCapability.build_cap_code(id, tab, type, cap)
    "#{id}-#{tab}-#{type}-#{cap}"
  end
  
  # Dato un codice di capability ritorna solo la parte del codice random.
  # @param [String] cap_code codice di capability da strippare.
  # @return [String] numero cap della capability.
  def LibCapability.strip_cap(cap_code)
    cap.cap_code.split('-')[3]
  end
  
  # Torna una capability.
  # @param [Integer] id chiave univoca dell'entita' della tabella.
  # @param [String] tab nome della tabella.
  # @return [Capability] oggetto di tipo capability.
  def LibCapability.find_cap_code(id, tab, type)
    require_cap(0, "capability", "R")
    Capability.find(:first, 
                    :conditions => ["cap_code LIKE ?", "#{id}-#{tab}-#{type}%"])
  end
  
  # Aggiunge un mapping tra utente e capability.
  # @param [User/Integer] nome dell'utente.
  # @return [CapabilityMapping] oggetto di tipo capability mapping.
  def LibCapability.add_map(username, cap_code)
    user = User.find(:first, :conditions => [ "username=?", username ])
    CapabilityMapping.create!(:user_id => user.id,
                              :rand_code => cap_code)
  rescue ActiveRecord::RecordInvalid => invalid
    invalid.record.errors
  rescue NoMethodError => error
    raise "Invalid User #{username}"
  end

  def LibCapability.add_group_map(group, cap_code)
    code = UserBackend.get_gid(group)
    GroupsCapabilityMapping.create!(:code => code ? code : group,
                                    :rand_code => cap_code)
  rescue ActiveRecord::RecordInvalid => invalid
    invalid.record.errors
  rescue NoMethodError => error
    raise error
  end
  
  # Access controll and verification #
  
  def LibCapability.only_root()
    suser = UserBackend.get_signed_user
    if suser and not suser.is_superuser?
      raise "Use sudo or root for use this method"
    end
  end
  
  def LibCapability.only_your_or_root(username)
    uid = UserBackend.get_uid(username)
    curr_user = UserBackend.get_signed_user
    if not (uid == curr_user.userid or curr_user.userid == 0)
      raise "You can't modify public key file for #{username} user, use root account"
    end
  end
  
  def LibCapability.require_cap(id, table, type)
    suser = UserBackend.get_signed_user
    if not suser.is_superuser?
      c = CapabilityMapping.find(:first, 
                                 :conditions => ["user_id=? and rand_code LIKE ?",
                                                 suser,
                                                 "#{id}-#{table}-#{type}%"])
      u = Capability.find(:first,
                          :conditions => [ "cap_code=?", c.rand_code ])
      if not u
        raise "User #{suser.username} don't have right capability"
      end
    end
  rescue NoMethodError => error
    if error.name == :is_superuser?
      raise "Invalid User"
    elsif error.name == :rand_code
      found = false
      UserBackend.user_groups.each do |g|
        c = GroupsCapabilityMapping.find(:first, 
                                         :conditions => ["code=? and rand_code LIKE ?",
                                                         g,
                                                         "#{id}-#{table}-#{type}%"])
        if c
          found = true
          break
        end
      end
      raise "User #{suser.username} don't have right capability" if not found
    elsif
      raise error
    end
  end
  
end
