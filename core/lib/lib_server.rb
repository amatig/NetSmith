# Classe per la gestione dei server.
# = Description
# Questa classe si occupa della gestione di server di varia natura configurabili in maniera remota dal sistema.
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

class LibServer
  
  # Aggiunge un nuovo server da gestire.
  # @param [String] ip indirizzo del server.
  # @param [String] conn_type tipo di connessione al server.
  # @param [String] hostname hostname del server.
  # @param [String] descr descrizione del server.
  # @return [Boolean/String] messaggio di esito dell'operazione.
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
  
  # Rimuove un server in gestione.
  # @param [String] ip indirizzo del server.
  # @return [Boolean/String] messaggio di esito dell'operazione.
  def del(ip)
    s = Server.find(:first, :conditions => ["ip = ?", ip])
    if s
      s.destroy
      true
    else
      "Server #{ip} not found"
    end
  end
  
  # Modifica un attributo di un server in gestione.
  # @param [String] ip indirizzo del server.
  # @param [String] attr nome dell'attributo del server.
  # @param [String/Integer/Boolean/...] value nuovo valore dell'attributo del server.
  # @return [Boolean/String] messaggio di esito dell'operazione.
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
  
  # Lista dei server in gestione.
  # @return [Array<String>] lista dei server.
  def list
    Server.all
  end
  
end