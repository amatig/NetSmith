# -*- ruby -*-

require 'core/database'

task :default => 'db:migrate'

desc "Test di aggiornamento valore user"
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
