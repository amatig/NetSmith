# -*- ruby -*-

require 'active_record'
require 'yaml'
# require 'logger'

namespace 'db' do
  
  task :init_connection do
    path = File.expand_path('../', __FILE__)
    dbconfig = YAML::load(File.open(File.join(path, 'config/database.yml')))
    dbconfig['database'] = File.join(path, dbconfig['database'])
    ActiveRecord::Base.establish_connection(dbconfig)
    # ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
    # ActiveRecord::Base.logger.level = Logger::DEBUG
  end
  
  task :enviroment => :init_connection do
    path = File.expand_path('../', __FILE__)
    Dir.glob(File.join(path, 'db/models/*.rb')).each { |r| require r } # importa tutti i models
  end
  
  desc "Migrazione del database attraverso gli scripts in db/migrate. Usare VERSION=x per una specifica versione."
  task :migrate => :init_connection do
    path = File.expand_path('../db/migrate', __FILE__)
    ActiveRecord::Migrator.migrate(path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
  
end