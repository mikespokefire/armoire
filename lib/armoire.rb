require 'singleton'
require 'yaml'
require 'erb'

require "armoire/setting"
require "armoire/version"
require "armoire/railtie" if defined?(Rails)

class Armoire
  include Singleton

  attr_accessor :settings

  def self.environment
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def self.[](key)
    instance.settings[key]
  end

  def self.env(key)
    raise EnvironmentVariableMissing, "Can't find #{key}" if ENV[key].nil?
    ENV[key]
  end

  def self.load!(path_to_config_file)
    instance.settings = Setting.new(instance.load_settings(path_to_config_file))
  end

  def load_settings(path_to_config_file)
    YAML.load(ERB.new(File.read(path_to_config_file)).result)
  rescue Errno::ENOENT => e
    raise MissingSettingsFile.new('The settings file cannot be found')
  end

  # When the settings file cannot be read, this exception will be raised
  class MissingSettingsFile < StandardError; end

  # When a config setting isn't set, this exception will be raised
  class ConfigSettingMissing < StandardError; end

  # When an ENV variable isn't set, this exception will be raised
  class EnvironmentVariableMissing < StandardError; end
end
