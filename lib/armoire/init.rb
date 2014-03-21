Rails.configuration.after_initialize do
  Armoire.load! Rails.root.join('config', 'application.yml')
end
