class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :userid
  
  def to_s
    return "#{username}"
  end  
end
