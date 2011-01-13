# NetSmith Importer

# require external libs
require "active_record"
require "yaml"
require "logger"
require "ftools"

# require all libs
Dir.glob("core/lib/*.rb").each { |r| require r }

# estabilish connection database
Database.instance

# require all models
Dir.glob("core/db/models/*.rb").each { |r| require r }
