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

module LibGroup
  
  def LibGroup.list
    UserBackend.all_groups
  end
  
  def LibGroup.list_capabilities(group)
    code = UserBackend.get_gid(group)
    GroupsCapabilityMapping.find(:all, :conditions => ["code = ?", code ? code : group])
  end
  
end
