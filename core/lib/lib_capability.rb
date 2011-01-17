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

class CapTool
  
  # Callback per il post creazione di un entita'.
  def after_create(e)
    Capability.create(:cap_code => "#{e.id}-#{e.class.to_s.downcase}-#{generate_cap}")
  end
  
end

# More utils for capabilities

# Random di 20 cifre per i codici di capabilities.
# @return [String] numero di 20 cifre random.
def generate_cap
  return (0...20).collect { rand(10) }.join 
end

# Compone codici di capabily.
# @param [Integer] id chiave univoca dell'entita' della tabella.
# @param [String] tab nome della tabella.
# @param [Integer/String] cap numero random.
# @return [String] codice di capability.
def build_cap_code(id, tab, cap)
  return "#{id}-#{tab}-#{cap}"
end
