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
      fields = {}
      f = File.open(file, "r")
      f.read.each do |r|
        match = r.scan(/\{\s*(\w+\s*\|\s*\w+)\s*\}/)
        if match
          match.each do |m|
            d = m[0].split("|")
            fields[d[0].strip] = d[1].strip
          end
        end
      end
      f.close
      fields
    else
      "Kickstart not exist"
    end
  end
  
end
