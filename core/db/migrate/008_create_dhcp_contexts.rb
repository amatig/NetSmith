class CreateDhcpContexts < ActiveRecord::Migration
  def self.up
    create_table :dhcp_contexts do |t|
      t.string :name
      t.integer :a_scope  #subnet, group, class, default, *hosts, **pool#
      t.integer :parent_id , :null => true
      t.string :def
      t.text :descr
    end
    Capability.create(:cap_code => "0-dhcp_context-R-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-dhcp_context-W-#{LibCapability.generate_cap}")
    Capability.create(:cap_code => "0-dhcp_context-X-#{LibCapability.generate_cap}")
    DhcpContext.create(:name => "default", 
                       :a_scope => DhcpContext::Default,
                       :parent_id => nil,
                       :def => "",
                       :descr => "global options")
  end
  
  def self.down
    drop_table :dhcp_contexts
  end
end
