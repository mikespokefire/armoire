require 'singleton'
require 'yaml'

require "armoire/setting"
require "armoire/version"

class Armoire
  include Singleton

  attr_accessor :settings

  def environment
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def self.[](key)
    instance.settings[key]
  end

  def self.load!(path_to_config_file)
    instance.settings = Setting.new(instance.load_settings(path_to_config_file))
  end

  def load_settings(path_to_config_file)
    YAML.load(ERB.new(File.read(path_to_config_file)).result)[environment]
  end

  # When a config setting isn't set, this exception will be raised
  class ConfigSettingMissing < StandardError; end
end
