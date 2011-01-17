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
    puts output(LibUser.new.add(args[:username], args[:public_key_file]))
  end
  
  desc "Del user to NetSmith system"
  task :del, [:username ] do |t, args|
    puts output(LibUser.new.del(args[:username]))
  end
  
  desc "Change public ssl key for user"
  task :change_ssl, [:username, :public_key_file ] do |t, args|
    puts output(LibUser.new.update_ssl_key(args[:username], args[:public_key_file]))
  end
  
end
