class Armoire
  class Railtie < Rails::Railtie
    config.before_configuration do
      Armoire.load! Rails.root.join('config', 'application.yml')
    end
  end
end
