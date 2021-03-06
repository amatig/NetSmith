# NetSmith Importer.
# = Description
# File di require principale per importare tutte le funzionalita' di NetSmith.
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

# Require external libs
require "rubygems"
require "active_record"
require "sqlite3"
require "yaml"
require "liquid"
require "logger"
require "ftools"

# Require all libs
require "core/lib/ns_utils"
require "core/lib/lib_database"
require "core/lib/lib_capability"
require "core/lib/ns_base"
require "core/lib/lib_kickstart"
require "core/lib/lib_server"
require "core/lib/lib_machine"
require "core/lib/lib_user"
require "core/lib/lib_group"

# Estabilish connection database
LibDatabase.instance

# Require all models
Dir.glob("core/db/models/*.rb").each { |r| require r }
