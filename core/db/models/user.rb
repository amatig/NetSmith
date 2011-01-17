class User < ActiveRecord::Base
  validates_uniqueness_of :username
  validates_uniqueness_of :userid
  validates_presence_of :username
  validates_presence_of :userid
  validates_presence_of :sslkey
  
  def to_s
    return "#{username}"
  end  
end
