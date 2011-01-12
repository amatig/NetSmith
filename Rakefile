# -*- ruby -*-

Dir.glob('core/*.rake').each { |r| import r }

task :default => 'db:migrate'

desc "Test di aggiornamento valore user."
task :test => 'db:enviroment' do
  require 'core/db/models/users.rb'
  u = Users.find(:first)
  if not u
    puts "new"
    u = Users.new({:name => 'giovanni', :cell => '4323424e32'})
  else
    p u
    u.name = 'vito'
  end
  if u.valid?
    puts u.save
  else
    puts u.errors
  end
end
