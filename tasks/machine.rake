# -*- ruby -*-

namespace "machine" do
  
  desc "Rimuove una macchina installabile."
  task :del, [:machine] do |t, args|
    puts output(LibMachine.del(args[:machine]))
  end
  
  desc "Modifica un attributo di una macchina installabile."
  task :edit, [:machine, :attr, :value] do |t, args|
    puts output(LibMachine.edit(args[:machine], args[:attr], args[:value]))
  end
  
  desc "Genera i file necessari all'installare di una macchina."
  task :generate, [:machine, :netsmith_ip, :pxe_options] do |t, args|
    puts output(LibMachine.generate(args[:machine], args[:netsmith_ip], args[:pxe_options]))
  end
  
  desc "Crea un server gestibile da una macchine installabile."
  task :to_server, [:machine, :conn_type] do |t, args|
    puts output(LibMachine.to_server(args[:machine], args[:conn_type]))
  end
  
  desc "Aggiunge una nuova macchina installabile."
  task :add, [:ip, :mac, :distro, :template, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    fields = LibKickstart.get_fields(args[:template])
    if fields.kind_of?(Hash)
      values = {}
      fields.each do |k, v|
        print "Enter #{k} (#{v}): "
        values[k] = $stdin.gets.chomp
      end
      puts output(LibMachine.add(args[:ip], 
                                     args[:mac], 
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
    puts output(LibMachine.list)
  end
  
end
