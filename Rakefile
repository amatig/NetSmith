# -*- ruby -*-

require "core/netsmith"

Dir.glob("tasks/*.rake").each { |r| import r }
task :default => "db:migrate"
