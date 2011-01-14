class Kickstart
  
  def add_template(file)
    if File.exist?(file)
      path = File.expand_path("../../../resources/templates", __FILE__)
      File.copy(file, path)
    else
      "File not exist"
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
  
  def actualize
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
