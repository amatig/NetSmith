class User < ActiveRecord::Base
  has_many :capability_mappings, :dependent => :destroy
  
  validates_presence_of :username
  validates_presence_of :userid
  validates_presence_of :sslkey
  validates_uniqueness_of :username
  validates_uniqueness_of :userid

  include UserBackend
  
  def to_s
    return "#{userid} #{username}"
  end
  
end
