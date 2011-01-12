# More Utils

def format_err(errors)
  msg = ""
  errors.each { |k,v| msg += "#{k}: #{v}\n" }
  return msg
end
