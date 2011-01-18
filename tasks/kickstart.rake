# -*- ruby -*-

namespace "ks" do
  
  desc "Aggiunge un template kickstart."
  task :add_template, [:file] do |t, args|
    puts output(LibKickstart.new.add_template(args[:file]))
  end
  
  desc "Rimuove un template kickstart."
  task :del_template, [:name] do |t, args|
    puts output(LibKickstart.new.del_template(args[:name]))
  end
  
  desc "Lista dei kickstart attualizzati."
  task :list do
    puts output(LibKickstart.new.list)
  end
  
  desc "Lista dei template kickstart."
  task :list_templates do
    puts output(LibKickstart.new.list_templates)
  end
  
  desc "Attualizza un template kickstart per una macchina installabile."
  task :actualize, [:ip] do |t, args|
    puts output(LibKickstart.new.actualize(args[:ip]))
  end
  
  desc "Mostra i campi parametrici di un template kickstart."
  task :get_fields, [:name] do |t, args|
    puts output(LibKickstart.new.get_fields(args[:name]))
  end
  
end
