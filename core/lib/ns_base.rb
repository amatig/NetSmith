# Classe base che estende ActiveRecord::Base per la gestione di model particolari.
# = Description
# Questa classe estende ActiveRecord::Base per la gestione di model che compiono particolari operazioni sui dati.
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

class NsBase < ActiveRecord::Base
  self.abstract_class = true
  
  after_create LibCapability
  
  # def self.find(*args)
  #   cap = nil
  #   if(args[1]!=nil and args[1].has_key?(:cap))
  #     cap = args[1].delete(:cap)
  #   end
  #   cap = Capability.find(:first, 
  #                         :conditions => ["cap_code=?",
  #                                         build_cap_code(0,self.name.to_s.downcase,cap)])
  #   if cap
  #     return super
  #   else
  #     return nil
  #   end
  # end
  
end
