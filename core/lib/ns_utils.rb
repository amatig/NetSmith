# More Utils

# Abbellisce l'output per i comandi rake.
# @param [String/Boolean/Hash/Array] message messaggio da formattare per un output piu' chiaro.
# @return [String] messaggio ben formattato per l'output da terminale.
def output(message)
  msg = ""
  if message.kind_of?(Hash) or message.kind_of?(ActiveRecord::Errors)
    message.each { |k, v| msg += "#{k}: #{v}\n" }
  else
    msg = message
  end
  msg
end

