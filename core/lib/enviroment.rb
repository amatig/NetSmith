class Enviroment
  
  def install
    nil
  end
  
  def add_machine(ip, mac, hostname, template, descr, values = {})
    Machines.all[0].delete
    ActiveRecord::Base.transaction do
      s = Machines.new(:ip => ip, 
                       :mac => mac,
                       :hostname => hostname,
                       :template => template,
                       :descr => descr)
      if s.valid?
        s.save
        values.each do |k, v|
          v = SettingValues.new(:machines_id => s.id,
                                :name => k,
                                :value => v)
          v.save
          puts format_err(v.errors)
        end
      else
        format_err(s.errors)
      end
      #raise
    end
    #if s.valid?
      #s.save
    #else
    #end
  end
  
  def list_machines
    Machines.all
  end
  
end
