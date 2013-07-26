class Armoire
  class Railtie < Rails::Railtie
    initializer "armoire.load_config" do
      Armoire.load! Rails.root.join('config', 'application.yml')
    end
  end
end
