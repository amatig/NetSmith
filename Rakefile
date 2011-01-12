# -*- ruby -*-

require "core/netsmith"

Dir.glob("task/*.rake").each { |r| import r }
task :default => "db:migrate"
