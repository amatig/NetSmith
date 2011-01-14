class MachineLib
    
  def del(ip)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      m.destroy
      true
    else
      "Machine #{ip} not found"
    end
  end
  
  def edit(ip, attr, value)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      m[attr] = value
      if m.valid?
        m.save
      else
        m.errors
      end
    else
      "Machine #{ip} not found"
    end
  end
  
  def add(ip, mac, hostname, template, descr, values = {})
    m = Machine.new(:ip => ip, 
                    :mac => mac,
                    :hostname => hostname,
                    :template => template,
                    :descr => descr)
    if m.valid?
      m.save
      esito = true
      values.each do |k, v|
        v = SettingValue.new(:machine_id => m.id,
                             :name => k,
                             :value => v)
        if v.valid?
          v.save
        else
          esito = v.errors
          m.destroy
          break
        end
      end
      esito
    else
      m.errors
    end
  end
  
  def list
    Machine.all
  end
  
end
