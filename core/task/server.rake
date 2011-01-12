# -*- ruby -*-

require "core/lib/server"

namespace "server" do
  
  desc "Aggiunge un nuovo server da gestire."
  task :add, [:conn_type, :ip, :host_name, :descr] do |t, args|
    Server.add(args[:conn_type], args[:ip], args[:host_name], args[:descr])
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
