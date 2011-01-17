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
  
  # Aggiunge una nuova macchina installabile.
  # @param [String] ip indirizzo della macchina.
  # @param [String] mac MAC Address della macchina.
  # @param [String] hostname hostname della macchina.
  # @param [String] template kickstart template per l'installazione della macchina.
  # @param [String] descr descrizione della macchina.
  # @param [Hash] values valori di attualizzazione per il template della macchina.
  # @return [Boolean/String] messaggio di esito dell'operazione.
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
  
  # Rimuove una macchina installabile.
  # @param [String] ip indirizzo di una macchina.
  # @return [Boolean/String] messaggio di esito dell'operazione.
  def del(ip)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      path = File.expand_path("../../../resources/ks", __FILE__)
      file = File.join(path, m.mac.gsub(":", "-") + "-" + m.template) # rimuove il ks
      File.delete(file) if File.exist?(file)
      m.destroy
      true
    else
      "Machine #{ip} not found"
    end
  end
  
  # Modifica un attributo di una macchina installabile.
  # @param [String] ip indirizzo di una macchina.
  # @param [String] attr nome dell'attributo di una macchina.
  # @param [String/Integer/Boolean/...] value nuovo valore dell'attributo di una macchina.
  # @return [Boolean/String] messaggio di esito dell'operazione.
  def edit(ip, attr, value)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      m[attr] = value
      if m.valid?
        m.save
      else
        return m.errors
      end
      a = SettingValue.find(:first, :conditions => ["machine_id = ? and name = ?", m.id, attr])
      if a
        a.value = value
        if a.valid?
          a.save
        else
          a.errors
        end
      else
        "Machine attribute #{attr} not found"
      end
    else
      "Machine #{ip} not found"
    end
  end
  
  # Lista delle macchine installabili.
  # @return [Array<String>] lista delle macchine.
  def list
    Machine.all
  end
  
end
