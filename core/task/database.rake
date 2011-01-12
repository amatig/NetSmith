# -*- ruby -*-

namespace "db" do
  
  desc "Migrazione del database attraverso gli scripts in db/migrate. Usare VERSION=x per una specifica versione."
  task :migrate do
    d = Database.instance
    d.migrate
  end
  
end
