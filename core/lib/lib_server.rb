# Modulo per la gestione dei server.
# = Description
# Questo modulo si occupa della gestione di server di varia natura configurabili in maniera remota dal sistema.
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

module LibServer
  
  # Aggiunge un nuovo server da gestire.
  # @param [String] ip indirizzo del server.
  # @param [String] conn_type tipo di connessione al server.
  # @param [String] descr descrizione del server.
  # @return [Server] oggetto di tipo server.
  def LibServer.add(ip, conn_type,  descr)
    s = Server.new(:ip => ip, 
                   :conn_type => conn_type,
                   :descr => descr)
    if s.save
      s
    else
      s.errors
    end
  end
  
  # Rimuove un server in gestione.
  # @param [Integer/String] server id o indirizzo del server.
  # @return [Server] oggetto di tipo server appen cancellato.
  def LibServer.del(server)
    s = Server.find(:first, :conditions => ["id = ? or ip = ?", server, server])
    if s
      s.destroy
    else
      raise StandardError, "Server #{server} don't exists"
    end
  end
  
  # Modifica un attributo di un server in gestione.
  # @param [Integer/String] server id o indirizzo del server.
  # @param [String] attr nome dell'attributo del server.
  # @param [String/Integer/Boolean/...] value nuovo valore dell'attributo del server.
  # @return [Boolean] messaggio di esito dell'operazione.
  def LibServer.edit(server, attr, value)
    s = Server.find(:first, :conditions => ["id = ? or ip = ?", server, server])
    if s
      s[attr] = value
      if s.save
        true
      else
        s.errors
      end
    else
      raise StandardError, "Server #{server} don't exists"
    end
  end
  
  # Lista dei server in gestione.
  # @return [Array<Server>] lista dei server.
  def LibServer.list
    Server.all
  end
  
end
