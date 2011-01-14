# -*- ruby -*-

namespace "ks" do
  
  desc "Aggiunge un template kickstart."
  task :add_template, [:file] do |t, args|
    puts output(KickstartLib.new.add_template(args[:file]))
  end
  
  desc "Lista dei kickstart 'attualizzati'."
  task :list do
    puts output(KickstartLib.new.list)
  end
  
  desc "Lista dei template kickstart."
  task :list_templates do
    puts output(KickstartLib.new.list_templates)
  end
  
  desc "Attualizza un template kickstart per una macchina in gestione."
  task :actualize, [:ip] do |t, args|
    puts output(KickstartLib.new.actualize(args[:ip]))
  end
  
  desc "Mostra i campi parametrici di un template kickstart."
  task :get_fields, [:name_ks] do |t, args|
    puts output(KickstartLib.new.get_fields(args[:name_ks]))
  end
  
end
