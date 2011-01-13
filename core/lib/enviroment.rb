class Enviroment
  
  def install
    nil
  end
  
  def add_machine(ip, mac, hostname, template, descr)
    s = Machines.new(:ip => ip, 
                     :mac => mac,
                     :hostname => hostname,
                     :template => template,
                     :descr => descr)
    if s.valid?
      s.save
    else
      format_err(s.errors)
    end
  end
  
  def list_machines
    Machines.all
  end
  
end
