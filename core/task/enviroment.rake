# -*- ruby -*-

namespace "env" do
  
  desc "Crea tutto l'enviroment per installare distribuzioni via rete."
  task :install do
    Enviroment.install
  end
  
end
