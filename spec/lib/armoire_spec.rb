require 'spec_helper'

describe Armoire do
  describe '#environment' do
    subject { described_class.instance.environment }

    before do
      described_class.environment = nil
    end

    context "ENV['RAILS_ENV'] is set" do
      before do
        @prev_rails_env = ENV['RAILS_ENV']
        ENV['RAILS_ENV'] = 'rails_env'
      end

      it "returns the result of ENV['RAILS_ENV'] as first priority" do
        expect(subject).to eql('rails_env')
      end

      after do
        ENV['RAILS_ENV'] = @prev_rails_env
      end
    end

    context "ENV['RACK_ENV'] is set" do
      before do
        @prev_rails_env = ENV['RAILS_ENV']
        @prev_rack_env = ENV['RACK_ENV']
        ENV['RAILS_ENV'] = nil
        ENV['RACK_ENV'] = 'rack_env'
      end

      it "returns the result of ENV['RACK_ENV'] as second priority" do
        expect(subject).to eql('rack_env')
      end

      after do
        ENV['RAILS_ENV'] = @prev_rails_env
        ENV['RACK_ENV'] = @prev_rack_env
      end
    end

    context "environment is explicitly set" do
      before do
        @prev_rails_env = ENV['RAILS_ENV']
        @prev_rack_env = ENV['RACK_ENV']
        ENV['RAILS_ENV'] = nil
        ENV['RACK_ENV'] = nil
        described_class.environment = 'no_rack'
      end

      it "returns the explicitly set environment" do
        expect(subject).to eql("no_rack")
      end

      after do
        ENV['RAILS_ENV'] = @prev_rails_env
        ENV['RACK_ENV'] = @prev_rack_env
        described_class.environment = nil
      end
    end


    context "nothing is set" do
      before do
        @prev_rails_env = ENV['RAILS_ENV']
        @prev_rack_env = ENV['RACK_ENV']
        ENV['RAILS_ENV'] = nil
        ENV['RACK_ENV'] = nil
      end

      it "returns development as a fallback if nothing else is set" do
        expect(subject).to eql("development")
      end

      after do
        ENV['RAILS_ENV'] = @prev_rails_env
        ENV['RACK_ENV'] = @prev_rack_env
      end
    end

    after do
      described_class.environment = nil
    end
  end

  describe '#[]' do
    context "simple config option" do
      subject { Armoire["simple_config_option"] }

      it { expect(subject).to eql("simple_config_option_value") }
    end

    context "referencing key via symbol instead of string" do
      subject { Armoire[:simple_config_option] }

      it { expect(subject).to eql("simple_config_option_value") }
    end

    context "erb config option" do
      subject { Armoire["erb_config_option"] }

      it { expect(subject).to eql("erb_config_option_value") }
    end

    context "nested config option" do
      subject { Armoire["nested"]["config"]["option"] }

      it { expect(subject).to eql("nested_config_option_value") }
    end

    context 'config setting is missing' do
      subject { Armoire["missing_setting"] }

      it "raises an error" do
        expect { subject }.to raise_error(Armoire::ConfigSettingMissing, '"missing_setting" is not set')
      end
    end

    context 'nested config setting is missing' do
      subject { Armoire["nested"]["config"]["missing_setting"] }

      it "raises an error" do
        expect { subject }.to raise_error(Armoire::ConfigSettingMissing, '"missing_setting" is not set')
      end
    end
  end

  describe '#fetch' do
    context "simple config option" do
      subject { Armoire.fetch("simple_config_option") }

      it { expect(subject).to eql("simple_config_option_value") }
    end

    context "referencing key via symbol instead of string" do
      subject { Armoire.fetch(:simple_config_option) }

      it { expect(subject).to eql("simple_config_option_value") }
    end

    context "erb config option" do
      subject { Armoire.fetch("erb_config_option") }

      it { expect(subject).to eql("erb_config_option_value") }
    end

    context "nested config option" do
      subject { Armoire.fetch("nested").fetch("config").fetch("option") }

      it { expect(subject).to eql("nested_config_option_value") }
    end

    context 'config setting is missing' do
      subject { Armoire.fetch("missing_setting") }

      it "raises an error" do
        expect { subject }.to raise_error(Armoire::ConfigSettingMissing, '"missing_setting" is not set')
      end
    end

    context 'nested config setting is missing' do
      subject { Armoire.fetch("nested").fetch("config").fetch("missing_setting") }

      it "raises an error" do
        expect { subject }.to raise_error(Armoire::ConfigSettingMissing, '"missing_setting" is not set')
      end
    end
  end

  describe '.load!' do
    context 'setting files exists' do
      before do
        Armoire.load! File.expand_path('../fixtures/custom_load.yml', File.dirname(__FILE__))
      end

      it "returns the new config settings" do
        expect(Armoire["custom_config_option"]).to eql("custom_config_option_value")
      end

      it "doesn't keep the original settings" do
        expect { Armoire["simple_config_option"] }.to raise_error(Armoire::ConfigSettingMissing, '"simple_config_option" is not set')
      end
    end

    context 'settings file does not exist' do
      subject { Armoire.load! File.expand_path('../fixtures/missing_file.yml', File.dirname(__FILE__)) }

      it "returns an exception" do
        expect { subject }.to raise_error(Armoire::MissingSettingsFile, 'The settings file cannot be found')
      end
    end

    after do
      Armoire.load! File.expand_path('../fixtures/application.yml', File.dirname(__FILE__))
    end
  end

  describe '.environment' do
    subject { Armoire.environment }

    it "returns the current environment armoire is set to read" do
      expect(subject).to eql("test")
    end
  end
end
