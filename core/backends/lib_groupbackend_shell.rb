module GroupBackend
  
  def self.list
    groups = []
    Etc.group do |g|
      groups << g
    end
    groups
  end
  
  def self.get_gid(groupname)
    Etc.getpwnam(groupname).uid
  rescue
    nil
  end

  def self.get_groups
    Process.groups
  rescue
    []
  end

end
