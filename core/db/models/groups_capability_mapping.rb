class GroupsCapabilityMapping < ActiveRecord::Base
  validates_presence_of :code
  validates_presence_of :rand_code
  validates_uniqueness_of :code, :scope => :rand_code
  
  def to_s
    return "#{code} --> #{rand_code}"
  end
  
end
