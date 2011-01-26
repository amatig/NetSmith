class DhcpContext < ActiveRecord::Base
  belongs_to :parent, :class_name => 'DhcpContext'
  has_many :dhcp_option_instances, :dependent => :destroy

  Default = 1
  Subnet = 2
  Group = 3
  Class = 4
  Hosts = 5
  Pool = 6

end
