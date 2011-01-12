# -*- ruby -*-

require "core/lib/server"

namespace "server" do
  
  desc "Aggiunge un nuovo server da gestire."
  task :add, [:conn_type, :ip, :hostname, :descr] do |t, args|
    ENV["HOSTNAME"] = nil
    Server.add(args[:conn_type], args[:ip], args[:hostname], args[:descr])
  end
  
  desc "Modifica un attributo di un server in gestione."
  task :edit, [:ip, :attr, :value] do |t, args|
    Server.edit(args[:ip], args[:attr], args[:value])
  end
  
  desc "Rimuove un server in gestione."
  task :del, [:ip] do |t, args|
    Server.del(args[:ip])
  end
  
  desc "Lista dei server in gestione."
  task :list do
    Server.list
  end
  
end
