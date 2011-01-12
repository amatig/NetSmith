# -*- ruby -*-

namespace "db" do
  
  desc "Migrazione del db tramite scripts in core/db/migrate, usare VERSION=x per una specifica versione."
  task :migrate do
    d = Database.instance
    d.migrate
  end
  
end
