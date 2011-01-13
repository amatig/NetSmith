# -*- ruby -*-

namespace "ks" do
  
  desc "Aggiunge un template kickstart."
  task :add_template, [:file] do |t, args|
    puts Kickstart.new.add_template(args[:file])
  end
  
  desc "Lista dei kickstart."
  task :list do
    puts Kickstart.new.list
  end
  
  desc "Lista dei template kickstart."
  task :list_templates do
    puts Kickstart.new.list_templates
  end
  
  desc "Mostra i campi parametrici di un template kickstart."
  task :get_fields, [:name_ks] do |t, args|
    p Kickstart.new.get_fields(args[:name_ks])
  end
  
end
