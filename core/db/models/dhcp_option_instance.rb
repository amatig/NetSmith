class DhcpOptionInstance < ActiveRecord::Base
  belongs_to :dhcp_context
  belongs_to :dhcp_option
  
  validates_presence_of :validate
  validates_presence_of :dhcp_context_id
  validates_presence_of :dhcp_option_id
  validates_uniqueness_of :dhcp_context_id, :scope => :dhcp_option_id
  
end
