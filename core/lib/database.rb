class DatabaseLib
  include Singleton
  
  def initialize
    path = File.expand_path("../../", __FILE__)
    f = File.open(File.join(path, "config/database.yml"), "r")
    dbconfig = YAML::load(f)
    f.close
    dbconfig["database"] = File.join(path, dbconfig["database"])
    ActiveRecord::Base.establish_connection(dbconfig)
  end
  
  def migrate
    path = File.expand_path("../../db/migrate", __FILE__)
    ActiveRecord::Migrator.migrate(path, ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end
  
end
