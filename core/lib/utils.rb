# More Utils

# Abbellisce l'output per il terminale rake dei tasks
def output(message)
  msg = ""
  if message.kind_of?(Hash)
    message.each { |k, v| msg += "#{k}: #{v}\n" }
  else
    msg = message
  end
  msg
end
