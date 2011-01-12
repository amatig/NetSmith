# -*- ruby -*-

require "core/netsmith"

Dir.glob("core/task/*.rake").each { |r| import r }
task :default => "db:migrate"
