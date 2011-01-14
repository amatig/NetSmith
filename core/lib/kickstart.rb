class KickstartLib
  
  def add_template(file)
    if File.exist?(file)
      path = File.expand_path("../../../resources/templates", __FILE__)
      File.copy(file, path)
    else
      "File #{file} not exist"
    end
  end
  
  def list
    path = File.expand_path("../../../resources/ks", __FILE__)
    files = Dir.new(path).entries
    files.delete(".")
    files.delete("..")
    files
  end
  
  def list_templates
    path = File.expand_path("../../../resources/templates", __FILE__)
    files = Dir.new(path).entries
    files.delete(".")
    files.delete("..")
    files
  end
  
  def actualize(ip)
    m = Machine.find(:first, :conditions => ["ip = ?", ip])
    if m
      values = {}
      m.setting_values.each do |v|
        values[v.name] = v.value
      end
      path = File.expand_path("../../../resources", __FILE__)
      file = File.join(path, "templates", m.template)
      if File.exist?(file)
        Dir.mkdir(File.join(path, "ks")) unless File.exist?(File.join(path, "ks"))
        unless values.empty?
          f = File.open(file, "r")
          template = Liquid::Template.parse(f.read)
          f.close
          f = File.new(File.join(path, "ks", m.mac.gsub(":", "-") + "-" + m.template), "w")
          f.write(template.render(values))
          f.close
        else
          File.copy(file, File.join(path, "ks", m.mac.gsub(":", "-") + "-" + m.template))
        end
        true
      else
        "File #{file} not exist"
      end
    else
      "Machine not found"
    end
  end
  
  def get_fields(name_ks)
    path = File.expand_path("../../../resources/templates", __FILE__)
    file = File.join(path, name_ks)
    if File.exist?(file)
      f = File.open(file, "r")
      template = Liquid::Template.parse(f.read)
      f.close
      fields = {}
      template.root.nodelist.each do |v|
        if v.kind_of?(Liquid::Variable)
          begin
            fields[v.name] = v.filters[0][0].to_s
          rescue
          end
        end
      end
      fields
    else
      "Kickstart not exist"
    end
  end
  
end
