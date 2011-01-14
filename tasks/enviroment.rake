# -*- ruby -*-

namespace "env" do
  
  desc "Crea tutto l'enviroment per installare distribuzioni via rete."
  task :install do
    puts Enviroment.new.install
  end
  
  desc "Aggiunge una nuova macchina da installare con l'enviroment via rete."
  task :add_machine, [:ip, :mac, :hostname, :name_ks, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    fields = Kickstart.new.get_fields(args[:name_ks])
    if fields.kind_of?(Hash)
      values = {}
      fields.each do |k, v|
        print "Enter #{k} (#{v}): "
        values[k] = $stdin.gets.chomp
      end
      puts Enviroment.new.add_machine(args[:ip], 
                                      args[:mac], 
                                      args[:hostname], 
                                      args[:name_ks], 
                                      args[:descr],
                                      values)
    else
      puts "Error kickstart file"
    end
  end
  
  desc "Lista delle macchine installate o da installare."
  task :list_machines do
    puts Enviroment.new.list_machines
  end
  
end
