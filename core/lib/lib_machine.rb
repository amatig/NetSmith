# Modulo per la gestione delle macchine da installare.
# = Description
# Questo modulo si occupa della gestione delle macchine che potranno essere installate via rete dal sistema.
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

module LibMachine
  
  # Aggiunge una nuova macchina installabile.
  # @param [String] ip indirizzo della macchina.
  # @param [String] mac MAC Address della macchina.
  # @param [String] distro nome della distro da l'installazione sulla macchina.
  # @param [String] template kickstart template per l'installazione della macchina.
  # @param [String] descr descrizione della macchina.
  # @param [Hash] values valori di attualizzazione per il template della macchina.
  # @return [Machine] oggetto di tipo machine.
  def LibMachine.add(ip, mac, distro, template, descr, values = {})
    file = File.expand_path("../../../tftpboot/images/#{distro}", __FILE__)
    unless File.exist?(file)
      raise StandardError, "Distro #{distro} don't exists"
    end
    m = Machine.new(:ip => ip, 
                    :mac => mac,
                    :distro => distro,
                    :template => template,
                    :descr => descr)
    if m.save
      esito = m
      values.each do |k, v|
        v = SettingValue.new(:machine_id => m.id,
                             :name => k,
                             :value => v)
        unless v.save
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
  # @param [Integer/String] machine id o indirizzo di una macchina.
  # @return [Machine] oggetto di tipo machine appena cancellato.
  def LibMachine.del(machine)
    m = Machine.find(:first, :conditions => ["id = ? or ip = ?", machine, machine])
    if m
      path = File.expand_path("../../../", __FILE__)
      mac = m.mac.gsub(":", "-")
      # rimuove il ks attualizzato
      file = File.join(path, "resources/ks", mac + "-" + m.template)
      File.delete(file) if File.exist?(file)
      # rimuove la entry nel pxe
      file = File.join(path, "tftpboot/pxelinux.cfg", "01-#{mac.downcase}")
      File.delete(file) if File.exist?(file)
      # rimuovere anche del dhcp la entry....
      m.destroy
    else
      raise StandardError, "Machine #{machine} don't exists"
    end
  end
  
  # Modifica un attributo di una macchina installabile.
  # @param [Integer/String] machine id o indirizzo di una macchina.
  # @param [String] attr nome dell'attributo di una macchina.
  # @param [String/Integer/Boolean/...] value nuovo valore dell'attributo di una macchina.
  # @return [Boolean] messaggio di esito dell'operazione.
  def LibMachine.edit(machine, attr, value)
    m = Machine.find(:first, :conditions => ["id = ? or ip = ?", machine, machine])
    if m
      m[attr] = value
      return m.errors unless m.save
      a = SettingValue.find(:first, :conditions => ["machine_id = ? and name = ?", m.id, attr])
      if a
        a.value = value
      else
        a = SettingValue.new(:machine_id => m.id, :name => attr, :value => value)
      end
      a.save ? a : a.errors
    else
      raise StandardError, "Machine #{machine} don't exists"
    end
  end
  
  # Genera i file necessari all'installare di una macchina.
  # @param [Integer/String] machine id or indirizzo di una macchina.
  # @param [String] netsmith_ip indirizzo pubblico della macchina in cui e' installato il sistema.
  # @param [String] options stringa di opzioni passabili al menu boot pxe.
  # @return [Boolean] messaggio di esito dell'operazione.
  def LibMachine.generate(machine, netsmith_ip, pxe_options = "")
    m = Machine.find(:first, :conditions => ["id = ? or ip = ?", machine, machine])
    if m
      path = File.expand_path("../../../", __FILE__)
      file = File.join(path, "resources/templates", "pxe.template")
      if File.exist?(file)
        f = File.open(file, "r")
        template = Liquid::Template.parse(f.read)
        f.close
        mac = m.mac.gsub(":", "-")
        f = File.new(File.join(path, "tftpboot/pxelinux.cfg", "01-#{mac.downcase}"), "w")
        text = template.render({
                                 "vmlinuz" => "images/#{m.distro}/images/pxeboot/vmlinuz",
                                 "initrd" => "images/#{m.distro}/images/pxeboot/initrd.img",
                                 "ip" => netsmith_ip,
                                 "kickstart" => "#{mac}-#{m.template}",
                                 "distro" => m.distro,
                                 "options" => pxe_options
                               })
        f.write(text)
        f.close
        true
      else
        raise IOError, "PXE template #{file} don't exists"
      end
    else
      raise StandardError, "Machine #{machine} don't exists"
    end      
  end
  
  # Crea un server gestibile da una macchine installabile.
  # @param [Integer/String] machine id or indirizzo di una macchina.
  # @param [String] conn_type tipo di connessione al server.
  # @return [Server] oggetti di tipo server generato dalla macchina.
  def LibMachine.to_server(machine, conn_type)
    m = Machine.find(:first, :conditions => ["id = ? or ip = ?", machine, machine])
    if m
      LibServer.add(m.ip, conn_type, m.descr)
    else
      raise StandardError, "Machine #{machine} don't exists"
    end
  end
  
  # Lista delle macchine installabili.
  # @return [Array<Machine>] lista delle macchine.
  def LibMachine.list
    Machine.all
  end
  
end
