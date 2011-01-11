# -*- ruby -*-

require 'core/database'

task :default => :migrate

task :environment do
  Database::connection
end

desc "Migrazione del database attraverso gli scripts in db/migrate. Usare VERSION=x per una specifica versione."
task :migrate => :environment do
  Database::migrate
end

desc "Test di aggiornamento valore"
task :test => :environment do
  require 'core/db/models/users.rb'
  # u = Users.all
  u = Users.find(:first)
  p u
  u.name = 'vito'
  if u.valid?
    puts u.save
  else
    puts u.errors
  end
end
