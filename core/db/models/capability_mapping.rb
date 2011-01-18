class CapabilityMapping < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user_id
  validates_presence_of :rand_code
  validates_uniqueness_of :user_id, :scope => :rand_code
  
  def to_s
    return "#{user.username} --> #{rand_code}"
  end
  
end
