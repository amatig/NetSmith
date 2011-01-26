class DhcpOption < ActiveRecord::Base
  has_many :dhcp_option_instances, :dependent => :destroy

  Option = 1
  Static = 2

  validates_presence_of :name
  validates_presence_of :o_scope
  validates_numericality_of :o_scope, :greater_then_or_equal_to => Option 
  validates_numericality_of :o_scope, :less_then_or_equal_to => Static 
  validates_uniqueness_of :name

end
