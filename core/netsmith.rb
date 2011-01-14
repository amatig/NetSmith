# NetSmith Importer

# require external libs
require "rubygems"
require "active_record"
require "yaml"
require "liquid"
require "logger"
require "ftools"

# require all libs
Dir.glob("core/lib/*.rb").each { |r| require r }

# estabilish connection database
DatabaseLib.instance

# require all models
Dir.glob("core/db/models/*.rb").each { |r| require r }
