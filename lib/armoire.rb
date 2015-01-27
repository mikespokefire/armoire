require 'singleton'
require 'yaml'
require 'erb'

require "armoire/setting"
require "armoire/version"

class Armoire
  include Singleton

  attr_accessor :settings
  attr_writer :environment

  def self.[](key)
    instance.settings[key]
  end

  def self.load!(path_to_config_file)
    instance.settings = Setting.new(instance.load_settings(path_to_config_file))
  end

  def self.environment=(environment)
    instance.environment = environment
  end

  def self.environment
    instance.environment
  end

  def self.fetch(key)
    instance.settings.fetch(key)
  end

  def environment
    @environment ||= ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def load_settings(path_to_config_file)
    YAML.load(ERB.new(File.read(path_to_config_file)).result)[environment]
  rescue Errno::ENOENT => e
    raise MissingSettingsFile.new('The settings file cannot be found')
  end

  # When the settings file cannot be read, this exception will be raised
  class MissingSettingsFile < StandardError; end

  # When a config setting isn't set, this exception will be raised
  class ConfigSettingMissing < StandardError; end
end

if defined?(Rails::Railtie)
  require "armoire/railtie"
elsif defined?(Rails.configuration)
  require "armoire/init"
end
