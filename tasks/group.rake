# -*- ruby -*-

namespace "group" do
  
  desc "List defined group into system"
  task :list do
    LibGroup.list.each do |g|
      puts "#{g.gid} #{g.name}"
    end
  end
  
  desc "Show for group capabilities"
  task :capabilities, [:group] do |t, args|
    puts output(LibGroup.list_capabilities(args[:group]))
  end
  
  desc "Base capability managemente"
  task :add_mapping, [:group, :cap_code] do |t, args|
    puts output(LibCapability.add_group_map(args[:group], args[:cap_code]))
  end
  
end
