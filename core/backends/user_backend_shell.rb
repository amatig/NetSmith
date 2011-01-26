module UserBackend
  
  def self.get_signed_user
    User.find(:first, :conditions => ["userid=?", Process.uid])
  end
  
  def self.get_uid(username)
    Etc.getpwnam(username).uid
  rescue
    nil
  end
  
  #Questo metodo e' solo accessibile attraverso l'oggetto User
  def is_superuser?
    (self.userid==0)
  end
  
  #Questo e' un medoto di modulo
  def self.is_superuser?(user_name)
    user = Etc.getpwnam(user_name)
    (user.uid==0)
  end
  
  def self.all_groups
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
  
  def self.user_groups
    Process.groups
  rescue
    []
  end
  
end
