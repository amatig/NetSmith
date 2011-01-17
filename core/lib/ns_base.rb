class NsBase < ActiveRecord::Base
  self.abstract_class = true
  
  after_create CapTool.new
  
  # def self.find(*args)
  #   cap = nil
  #   if(args[1]!=nil and args[1].has_key?(:cap))
  #     cap = args[1].delete(:cap)
  #   end
  #   cap = Capability.find(:first, 
  #                         :conditions => ["cap_code=?",
  #                                         build_cap_code(0,self.name.to_s.downcase,cap)])
  #   if cap
  #     return super
  #   else
  #     return nil
  #   end
  # end
  
end
