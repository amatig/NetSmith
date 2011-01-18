# Classe e funzioni per la gestione delle capabilities.
# = Description
# Questa classe e funzioni si occupano della gestione delle capabilities per il controllo degli accessi alle risorse.
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
  
  # Callback per il post creazione di un entita'.
  def LibCapability.after_create(e)
    Capability.create(:cap_code => "#{e.id}-#{e.class.to_s.downcase}-#{generate_cap}")
  end
  
  # Random di 20 cifre per i codici di capabilities.
  # @return [String] numero di 20 cifre random.
  def LibCapability.generate_cap
    (0...20).collect { rand(10) }.join 
  end
  
  # Compone codici di capabily.
  # @param [Integer] id chiave univoca dell'entita' della tabella.
  # @param [String] tab nome della tabella.
  # @param [Integer/String] cap numero random.
  # @return [String] codice di capability.
  def LibCapability.build_cap_code(id, tab, cap)
    "#{id}-#{tab}-#{cap}"
  end

  def LibCapability.strip_cap(cap_code)
    cap.cap_code.split('-')[2]
  end
  
  def LibCapability.find_cap_code(id, tab)
    Capability.find(:first, 
                    :conditions => [ "cap_code LIKE ?","#{id}-#{tab}-%"])
  end

  def LibCapability.add_map(user, cap_code)
    c = CapabilityMapping.new(:user_id => user,
                              :rand_code =>cap_code)
    if c.valid?
      c.save
    else
      c.errors
    end
    c
  end
  
end
