# -*- ruby -*-

require "core/lib/enviroment"

namespace "env" do
  
  desc "Crea tutto l'enviroment per installare distribuzioni linux via rete."
  task :install do
    Enviroment.install
  end
  
end
