class MachineLib
    
  def del(ip)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      m.destroy
      true
    else
      "Machine not found"
    end
  end
  
  def edit(ip, attr, value)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      m[attr] = value
      if m.valid?
        m.save
      else
        format_err(m.errors)
      end
    else
      "Machine not found"
    end
  end
  
  def add(ip, mac, hostname, template, descr, values = {})
    s = Machine.new(:ip => ip, 
                    :mac => mac,
                    :hostname => hostname,
                    :template => template,
                    :descr => descr)
    if s.valid?
      s.save
      esito = true
      values.each do |k, v|
        v = SettingValue.new(:machine_id => s.id,
                             :name => k,
                             :value => v)
        if v.valid?
          v.save
        else
          esito = format_err(v.errors)
          s.destroy
          break
        end
      end
      esito
    else
      format_err(s.errors)
    end
  end
  
  def list
    Machine.all
  end
  
end
