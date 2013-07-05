require 'singleton'
require 'yaml'

require "armoire/setting"
require "armoire/version"

class Armoire
  include Singleton

  attr_reader :settings

  def environment
    ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
  end

  def self.[](key)
    instance.load!
    instance.settings[key]
  end

  def load!
    @settings ||= Setting.new(load_settings)
  end

  def load_settings
    YAML.load(ERB.new(File.read("config/application.yml")).result)[environment]
  end

  # When a config setting isn't set, this exception will be raised
  class ConfigSettingMissing < StandardError; end
end
