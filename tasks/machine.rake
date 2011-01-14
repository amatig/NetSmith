# -*- ruby -*-

namespace "machine" do
  
  desc "Rimuove una macchina gestita dall'enviroment."
  task :del, [:ip] do |t, args|
    puts output(MachineLib.new.del(args[:ip]))
  end
  
  desc "Modifica un attributo di una macchina in gestione con l'enviroment."
  task :edit, [:ip, :attr, :value] do |t, args|
    puts output(MachineLib.new.edit(args[:ip], args[:attr], args[:value]))
  end
  
  desc "Aggiunge una nuova macchina da gestire con l'enviroment."
  task :add, [:ip, :mac, :hostname, :name_ks, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    fields = KickstartLib.new.get_fields(args[:name_ks])
    if fields.kind_of?(Hash)
      values = {}
      fields.each do |k, v|
        print "Enter #{k} (#{v}): "
        values[k] = $stdin.gets.chomp
      end
      puts output(MachineLib.new.add(args[:ip], 
                                     args[:mac], 
                                     args[:hostname], 
                                     args[:name_ks], 
                                     args[:descr],
                                     values))
    else
      puts output("Error kickstart file")
    end
  end
  
  desc "Lista delle macchine gestite dall'enviroment."
  task :list do
    puts output(MachineLib.new.list)
  end
  
end
