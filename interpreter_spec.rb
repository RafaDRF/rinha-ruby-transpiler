require_relative 'interpreter'
require 'json'

describe Interpreter do
  let(:evalue) { described_class.evalue(formated_expression(json_string)) }

  context 'Inteiro' do
    let(:json_string) do
      '{
        "kind": "Int",
        "value": 3
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

  context 'Add' do
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

  context 'Sub' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 3
        },
        "op": "Sub",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evalue).to eq(-4) }
  end

  context 'Mul' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 5
        },
        "op": "Mul",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evalue).to eq(35) }
  end

  context 'Div' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 4
        },
        "op": "Div",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evalue).to eq(2) }
  end

  context 'Rem' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 4
        },
        "op": "Rem",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evalue).to eq(0) }
  end

  context 'Igualdade  "a" == "a"' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Str",
          "value": "a"
        },
        "op": "Eq",
        "rhs": {
          "kind": "Str",
          "value": "a"
        }
      }'
    end

    it { expect(evalue).to eq(true) }
  end

  context 'Diferente  "a" != "a"' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Str",
          "value": "a"
        },
        "op": "Neq",
        "rhs": {
          "kind": "Str",
          "value": "a"
        }
      }'
    end

    it { expect(evalue).to eq(false) }
  end

  context 'Menor  1 < 2' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 1
        },
        "op": "Lt",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evalue).to eq(true) }
  end

  context 'Maior  2 > 3' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 2
        },
        "op": "Gt",
        "rhs": {
          "kind": "Int",
          "value": 3
        }
      }'
    end

    it { expect(evalue).to eq(false) }
  end

  context 'Menor ou igual 5 <= 7' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 5
        },
        "op": "Lte",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evalue).to eq(true) }
  end

  context 'Maior ou igual 5 >= 7' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 5
        },
        "op": "Gte",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evalue).to eq(false) }
  end

  context 'And true && false' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Bool",
          "value": true
        },
        "op": "And",
        "rhs": {
          "kind": "Bool",
          "value": false
        }
      }'
    end

    it { expect(evalue).to eq(false) }
  end

  context 'Or true || false' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Bool",
          "value": true
        },
        "op": "Or",
        "rhs": {
          "kind": "Bool",
          "value": false
        }
      }'
    end

    it { expect(evalue).to eq(true) }
  end
end

def formated_expression(string_json)
  JSON.parse(string_json, symbolize_names: true)
end
