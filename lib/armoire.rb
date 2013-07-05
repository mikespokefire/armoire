require 'singleton'
require 'yaml'

require "armoire/version"

class Armoire
  include Singleton

  attr_reader :settings

  def environment
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def self.[](setting)
    instance.load!

    instance.settings.fetch(setting) do
      raise ConfigSettingMissing, %Q{"#{setting}" is not set}
    end
  end

  def load!
    @settings ||= load_settings
  end

  def load_settings
    YAML.load(ERB.new(File.read("config/application.yml")).result)[environment]
  end

  # When a config setting isn't set, this exception will be raised
  class ConfigSettingMissing < StandardError; end
end
