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
  
  desc "Aggiunge una nuova macchina da installabile."
  task :add, [:ip, :mac, :hostname, :name_ks, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    fields = LibKickstart.new.get_fields(args[:name_ks])
    if fields.kind_of?(Hash)
      values = {}
      fields.each do |k, v|
        print "Enter #{k} (#{v}): "
        values[k] = $stdin.gets.chomp
      end
      puts output(LibMachine.new.add(args[:ip], 
                                     args[:mac], 
                                     args[:hostname], 
                                     args[:name_ks], 
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
