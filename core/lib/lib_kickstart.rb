# Classe per la gestione dei kickstart file.
# = Description
# Questa classe si occupa della gestione dei file di kickstart utili per le installazioni di alcune distro linux.
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

module LibKickstart
  
  # Aggiunge un template kickstart.
  # @param [String] file filename completo di percorso assoluto all'interno del disco.
  # @return [Boolean] messaggio di esito dell'operazione.
  def LibKickstart.add_template(file)
    if File.exist?(file)
      path = File.expand_path("../../../resources/templates", __FILE__)
      File.copy(file, path)
    else
      raise IOError, "File #{file} don't exists"
    end
  end
  
  # Rimuove un template kickstart.
  # @param [String] name nome di un template kickstart gia' nel sistema.
  # @return [Boolean] messaggio di esito dell'operazione.
  def LibKickstart.del_template(name)
    path = File.expand_path("../../../resources/templates", __FILE__)
    file = File.join(path, name)
    if File.exist?(file)
      File.delete(file)
      true
    else
      raise IOError, "Kickstart template #{name} don't exists"
    end
  end
  
  # Lista dei kickstart attualizzati.
  # @return [Array<String>] lista dei file.
  def LibKickstart.list
    path = File.expand_path("../../../resources/ks", __FILE__)
    files = Dir.new(path).entries
    files.delete(".")
    files.delete("..")
    files
  end
  
  # Lista dei template kickstart.
  # @return [Array<String>] lista dei file.
  def LibKickstart.list_templates
    path = File.expand_path("../../../resources/templates", __FILE__)
    files = Dir.new(path).entries
    files.delete(".")
    files.delete("..")
    files
  end
  
  # Attualizza un template kickstart per una macchina in gestione.
  # @param [String] ip indirizzo di una macchina installabile.
  # @return [Boolean] messaggio di esito dell'operazione.
  def LibKickstart.actualize(ip)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      values = {}
      m.setting_values.each { |v| values[v.name] = v.value }
      path = File.expand_path("../../../resources", __FILE__)
      file = File.join(path, "templates", m.template)
      if File.exist?(file)
        Dir.mkdir(File.join(path, "ks")) unless File.exist?(File.join(path, "ks"))
        unless values.empty?
          f = File.open(file, "r")
          template = Liquid::Template.parse(f.read)
          f.close
          f = File.new(File.join(path, "ks", m.mac.gsub(":", "-") + "-" + m.template), "w")
          f.write(template.render(values))
          f.close
        else
          File.copy(file, File.join(path, "ks", m.mac.gsub(":", "-") + "-" + m.template))
        end
        true
      else
        raise IOError, "Kickstart template #{file} don't exists"
      end
    else
      raise StandardError, "Machine #{ip} don't exists"
    end
  end
  
  # Ritorna i campi parametrici di un template kickstart.
  # @param [String] name nome di un template kickstart gia' nel sistema.
  # @return [Hash] dizionario delle variabili nel template { nome => tipo, ... }.
  def LibKickstart.get_fields(name)
    path = File.expand_path("../../../resources/templates", __FILE__)
    file = File.join(path, name)
    if File.exist?(file)
      f = File.open(file, "r")
      template = Liquid::Template.parse(f.read)
      f.close
      fields = {}
      template.root.nodelist.each do |v|
        if v.kind_of?(Liquid::Variable)
          fields[v.name] = v.filters[0][0].to_s
        end
      end
      fields
    else
      raise IOError, "Kickstart template #{file} don't exists"
    end
  end
  
end
