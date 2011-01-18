class Capability < ActiveRecord::Base
  validates_presence_of :cap_code
  
  def to_s
    return "#{cap_code}"
  end
  
end