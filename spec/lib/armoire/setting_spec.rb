require 'spec_helper'

describe Armoire::Setting do
  let(:setting) do
    described_class.new({
      "simple" => "simple value",
      "nested" => {
        "config" => "nested config value"
      }
    })
  end

  describe '#[]' do
    context 'setting is a value' do
      subject { setting["simple"] }

      it 'returns the value' do
        expect(subject).to eql("simple value")
      end
    end

    context 'setting is a hash' do
      subject { setting["nested"] }

      it 'returns a new setting object' do
        expect(subject).to be_an_instance_of(described_class)
      end
    end

    context 'it can be chained' do
      subject { setting["nested"]["config"] }
      it 'returns the nested value' do
        expect(subject).to eql("nested config value")
      end
    end

    context 'missing key' do
      subject { setting["missing_setting"] }
      it "raises an error" do
        expect { subject }.to raise_error(Armoire::ConfigSettingMissing, '"missing_setting" is not set')
      end
    end
  end

  describe '#fetch' do
    context 'setting is a value' do
      subject { setting.fetch("simple") }

      it 'returns the value' do
        expect(subject).to eql("simple value")
      end
    end

    context 'setting is a hash' do
      subject { setting.fetch("nested") }

      it 'returns a new setting object' do
        expect(subject).to be_an_instance_of(described_class)
      end
    end

    context 'it can be chained' do
      subject { setting.fetch("nested").fetch("config") }
      it 'returns the nested value' do
        expect(subject).to eql("nested config value")
      end
    end

    context 'missing key' do
      subject { setting.fetch("missing_setting") }
      it "raises an error" do
        expect { subject }.to raise_error(Armoire::ConfigSettingMissing, '"missing_setting" is not set')
      end
    end
  end
end
