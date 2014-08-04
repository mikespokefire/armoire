ENV['RACK_ENV'] = 'test'

require 'armoire'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = 'random'

  config.before(:all) do
    Armoire.load! File.expand_path('fixtures/application.yml', File.dirname(__FILE__))
  end
end
