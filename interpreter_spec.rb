require_relative 'interpreter'
require 'json'

describe Interpreter do
  let(:evalue) { described_class.evalue(expression) }

  context 'Inteiro' do
    let(:expression) do
      formated_expression('{
        "kind": "Int",
        "value": 3,
        "location": {
          "start": 0,
          "end": 1,
          "filename": "int.rinha"
        }
      }')
    end

    it { expect(evalue).to eq(3) }
  end

  context 'Bool' do
    let(:expression) do
      formated_expression('{
        "kind": "Bool",
        "value": true
      }')
    end

    it { expect(evalue).to eq(true) }
  end

  context 'String' do
    let(:expression) do
      formated_expression('{
        "kind": "Str",
        "value": "palavra usada"
      }')
    end

    it { expect(evalue).to eq('palavra usada') }
  end

  context 'add' do
    let(:expression) do
      formated_expression('{
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
      }')
    end

    it { expect(evalue).to eq(5) }
  end
end

def formated_expression(string_json)
  JSON.parse(string_json, symbolize_names: true)
end
