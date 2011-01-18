# -*- ruby -*-

namespace "server" do
  
  desc "Aggiunge un nuovo server da gestire."
  task :add, [:ip, :conn_type, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    puts output(LibServer.add(args[:ip], args[:conn_type], args[:descr]))
  end
  
  desc "Modifica un attributo di un server in gestione."
  task :edit, [:server, :attr, :value] do |t, args|
    puts output(LibServer.edit(args[:server], args[:attr], args[:value]))
  end
  
  desc "Rimuove un server in gestione."
  task :del, [:server] do |t, args|
    puts output(LibServer.del(args[:server]))
  end
  
  desc "Lista dei server in gestione."
  task :list do
    puts output(LibServer.list)
  end
  
end
