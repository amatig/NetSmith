# -*- ruby -*-

require "core/backends/lib_userbackend_shell"
require "core/backends/lib_groupbackend_shell"
require "core/netsmith"

Dir.glob("tasks/*.rake").each { |r| import r }
task :default => "db:migrate"
