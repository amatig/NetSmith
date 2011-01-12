# NetSmith Importer

# external require
require "active_record"
require "yaml"
require "logger"

# require all lib
Dir.glob("core/lib/*.rb").each { |r| require r }

# estabilish connection database
Database.instance

# require all models
Dir.glob("core/db/model/*.rb").each { |r| require r }
