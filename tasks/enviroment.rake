# -*- ruby -*-

namespace "env" do
  
  desc "Crea tutto l'enviroment per installare distribuzioni via rete."
  task :install do
    puts Enviroment.new.install
  end
  
  desc "Aggiunge una nuova macchina da installare con l'enviroment via rete."
  task :add_machine, [:ip, :mac, :hostname, :name_ks, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    m = Enviroment.new.add_machine(args[:ip], 
                                   args[:mac], 
                                   args[:hostname], 
                                   args[:name_ks], 
                                   args[:descr])
    if m == true
      values = {}
      ks = Kickstart.new
      fields = ks.get_fields(args[:name_ks])
      if fields.kind_of?(Hash)
        fields.each do |k, v|
          print "Enter #{k} (#{v}): "
          values[k] = $stdin.gets.chomp
        end
        puts true # salvare i valori
      else
        puts "Error kickstart file" # salva cmq la macchina :|
      end
    else
      puts m
    end
  end
  
  desc "Lista delle macchine installate o da installare."
  task :list_machines do
    puts Enviroment.new.list_machines
  end
  
end
