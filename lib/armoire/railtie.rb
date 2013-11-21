class Armoire
  class Railtie < Rails::Railtie
    config.before_configuration do
      env = Armoire.environment
      Armoire.load! Rails.root.join('config', 'environments', "#{env}.yml")
    end
  end
end
