# -*- ruby -*-

require "core/backends/user_backend_shell"
require "core/netsmith"

Dir.glob("tasks/*.rake").each { |r| import r }
task :default => "db:migrate"
