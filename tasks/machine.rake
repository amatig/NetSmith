# -*- ruby -*-

namespace "machine" do
  
  desc "Rimuove una macchina installabile."
  task :del, [:ip] do |t, args|
    puts output(LibMachine.new.del(args[:ip]))
  end
  
  desc "Modifica un attributo di una macchina installabile."
  task :edit, [:ip, :attr, :value] do |t, args|
    puts output(LibMachine.new.edit(args[:ip], args[:attr], args[:value]))
  end
  
  desc "Genera i file necessari all'installare di una macchina."
  task :generate, [:ip, :netsmith_ip, :pxe_options] do |t, args|
    puts output(LibMachine.new.generate(args[:ip], args[:netsmith_ip], args[:pxe_options]))
  end
  
  desc "Crea un server gestibile da una macchine installabile."
  task :to_server, [:ip, :conn_type] do |t, args|
    puts output(LibMachine.new.to_server(args[:ip], args[:conn_type]))
  end
  
  desc "Aggiunge una nuova macchina installabile."
  task :add, [:ip, :mac, :hostname, :distro, :template, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    fields = LibKickstart.new.get_fields(args[:template])
    if fields.kind_of?(Hash)
      values = {}
      fields.each do |k, v|
        print "Enter #{k} (#{v}): "
        values[k] = $stdin.gets.chomp
      end
      puts output(LibMachine.new.add(args[:ip], 
                                     args[:mac], 
                                     args[:hostname], 
                                     args[:distro],
                                     args[:template], 
                                     args[:descr],
                                     values))
    else
      puts output("Error kickstart file")
    end
  end
  
  desc "Lista delle macchine installabili."
  task :list do
    puts output(LibMachine.new.list)
  end
  
end
