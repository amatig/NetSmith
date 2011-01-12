# -*- ruby -*-

require "core/lib/database"

namespace "db" do
    
  desc "Migrazione del database attraverso gli scripts in db/migrate. Usare VERSION=x per una specifica versione."
  task :migrate do
    Database.migrate
  end
  
end
