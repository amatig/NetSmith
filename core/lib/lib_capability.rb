# Some stuff for support capabilities

def generate_cap
  return (0...20).collect { rand(10) }.join 
end

def build_cap_code(id, tab, cap)
  return "#{id}-#{tab}-#{cap}"
end


class CapTool
  
  def initialize
  end
  
  def after_create(record)
    Capability.create(:cap_code => "#{record.id}-#{record.class.to_s.downcase}-#{generate_cap}")
  end
  
end
