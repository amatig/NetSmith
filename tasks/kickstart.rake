# -*- ruby -*-

namespace "ks" do
  
  desc "Aggiunge un template kickstart."
  task :add_template, [:file] do |t, args|
    puts output(LibKickstart.add_template(args[:file]))
  end
  
  desc "Rimuove un template kickstart."
  task :del_template, [:name] do |t, args|
    puts output(LibKickstart.del_template(args[:name]))
  end
  
  desc "Lista dei kickstart attualizzati."
  task :list do
    puts output(LibKickstart.list)
  end
  
  desc "Lista dei template kickstart."
  task :list_templates do
    puts output(LibKickstart.list_templates)
  end
  
  desc "Attualizza un template kickstart per una macchina installabile."
  task :actualize, [:machine] do |t, args|
    puts output(LibKickstart.actualize(args[:machine]))
  end
  
  desc "Ritorna i campi parametrici di un template kickstart."
  task :get_fields, [:name] do |t, args|
    puts output(LibKickstart.get_fields(args[:name]))
  end
  
end
