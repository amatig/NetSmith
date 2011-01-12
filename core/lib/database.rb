class Database
  include Singleton
  
  def initialize
    path = File.expand_path("../../", __FILE__)
    dbconfig = YAML::load(File.open(File.join(path, "config/database.yml")))
    dbconfig["database"] = File.join(path, dbconfig["database"])
    ActiveRecord::Base.establish_connection(dbconfig)
    # ActiveRecord::Base.logger = Logger.new(File.open("database.log", "a"))
    # ActiveRecord::Base.logger.level = Logger::DEBUG
  end
  
  def migrate
    path = File.expand_path("../../db/migrate", __FILE__)
    ActiveRecord::Migrator.migrate(path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
  
end
