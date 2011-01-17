# Classe singleton per la gestione del database.
# = Description
# Questa classe si occupa della connessione al database e della gestione delle tabelle.
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

class LibDatabase
  include Singleton
  
  # Inizializzatione del singleton.
  def initialize
    path = File.expand_path("../../", __FILE__)
    f = File.open(File.join(path, "config/database.yml"), "r")
    dbconfig = YAML::load(f)
    f.close
    dbconfig["database"] = File.join(path, dbconfig["database"])
    ActiveRecord::Base.establish_connection(dbconfig)
    ActiveRecord::Base.logger = Logger.new(STDERR)
    ActiveRecord::Base.logger.level = Logger::INFO
  end
  
  # Migrazione del db tramite scripts in core/db/migrate.
  # @param [Integer] version indica il numero di versione della struttura del database, 0 droppa ogni tabella.
  def migrate(version = nil)
    path = File.expand_path("../../db/migrate", __FILE__)
    ActiveRecord::Migrator.migrate(path, version ? version.to_i : nil)
  end
  
end
