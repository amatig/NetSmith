# -*- ruby -*-

namespace "user" do
  
  desc "Test Task."
  task :test do
    puts Process.uid
    puts Process.groups
    puts Etc.getpwnam("spaghetty")
  end
  
  desc "Add user to NetSmith system"
  task :add, [:username, :public_key_file] do |t, args|
    puts output(LibUser.add(args[:username], args[:public_key_file]))
  end
  
  desc "Del user to NetSmith system"
  task :del, [:username ] do |t, args|
    puts output(LibUser.del(args[:username]))
  end
  
  desc "List defined user into NetSmith system"
  task :list do |t, args|
    puts output(LibUser.list)
  end
  
  desc "Change public ssl key for user"
  task :change_ssl, [:username, :public_key_file ] do |t, args|
    puts output(LibUser.update_ssl_key(args[:username], args[:public_key_file]))
  end
  
  desc "Add server access capability to a user"
  task :access_to, [:username, :server_ip] do |t, args|
    puts output(LibUser.add_access_to(args[:username], args[:server_ip]))
  end
  
  desc "Show for user capabilities"
  task :capabilities do 
    puts output(LibUser.list_capabilities)
  end
  
  desc "Base capability managemente"
  task :add_mapping, [:user, :cap_code] do |t, args|
    puts output(LibCapability.add_map(args[:user], args[:cap_code]))
  end

  desc "Search for capability"
  task :find_capability, [:id, :table, :type] do |t, args|
    puts output(LibCapability.find_cap_code(args[:id], args[:table], args[:type]))
  end
  
end
