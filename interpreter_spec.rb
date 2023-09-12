require_relative 'interpreter'
require 'json'

describe Interpreter do
  let(:evalue) { described_class.evalue(formated_expression(json_string)) }

  context 'Inteiro' do
    let(:json_string) do
      '{
        "kind": "Int",
        "value": 3,
      }'
    end

    it { expect(evalue).to eq(3) }
  end

  context 'Bool' do
    let(:json_string) do
      '{
        "kind": "Bool",
        "value": true
      }'
    end

    it { expect(evalue).to eq(true) }
  end

  context 'String' do
    let(:json_string) do
      '{
        "kind": "Str",
        "value": "palavra usada"
      }'
    end

    it { expect(evalue).to eq('palavra usada') }
  end

  context 'add' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 3
        },
        "op": "Add",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evalue).to eq(5) }
  end
end

def formated_expression(string_json)
  JSON.parse(string_json, symbolize_names: true)
end
