class CapabilityMapping < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :rand_code

  def to_s
    return "#{user.username}-->#{rand_code}"
  end
end
