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
  end
end
