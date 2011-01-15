# Classe per la gestione delle macchine da installare.
# = Description
# Questa classe si occupa della gestione delle macchine che potranno essere installate via rete dal sistema.
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

class LibMachine
  
  # Rimuove una macchina installabile.
  def del(ip)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      m.destroy
      true
    else
      "Machine #{ip} not found"
    end
  end
  
  # Modifica un attributo di una macchina installabile.
  def edit(ip, attr, value)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      m[attr] = value
      if m.valid?
        m.save
      else
        m.errors
      end
    else
      "Machine #{ip} not found"
    end
  end
  
  # Aggiunge una nuova macchina da installabile.
  def add(ip, mac, hostname, template, descr, values = {})
    m = Machine.new(:ip => ip, 
                    :mac => mac,
                    :hostname => hostname,
                    :template => template,
                    :descr => descr)
    if m.valid?
      m.save
      esito = true
      values.each do |k, v|
        v = SettingValue.new(:machine_id => m.id,
                             :name => k,
                             :value => v)
        if v.valid?
          v.save
        else
          esito = v.errors
          m.destroy
          break
        end
      end
      esito
    else
      m.errors
    end
  end
  
  # Lista delle macchine installabili.
  # @return [Array<String>] lista delle macchine.
  def list
    Machine.all
  end
  
end
