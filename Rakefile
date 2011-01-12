# -*- ruby -*-

Dir.glob('core/task/*.rake').each { |r| import r }

task :default => 'db:migrate'

desc "Test di aggiornamento valore user."
task :test => 'db:enviroment' do
  u = Servers.find(:first)
  if true
    puts 'new server'
    u = Servers.new(:ip => '127.0.0.1', 
                    :conn_type => 'local',
                    :mac => '00:00:00:0F:00:00')
    p u
  else
    p u
    u.desc = 'vito'
  end
  if u.valid?
    puts u.save
  else
    puts u.errors
  end
end
