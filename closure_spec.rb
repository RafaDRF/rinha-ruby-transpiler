require_relative 'closure'

describe Closure do
  context '#parse_local_variables' do
    let(:parameters) do
      [{ text: 'a', location: { start: 14, end: 15, filename: 'source.rinha' } },
       { text: 'b', location: { start: 17, end: 18, filename: 'source.rinha' } }]
    end

    let(:arguments) do
      [10, 20]
    end

    let(:value) do
      { kind: 'Binary', lhs: { kind: 'Var', text: 'a', location: { start: 29, end: 30, filename: 'source.rinha' } },
        op: 'Add', rhs: { kind: 'Var', text: 'b', location: { start: 33, end: 34, filename: 'source.rinha' } } }
    end

    it { expect(described_class.new(parameters, value, {}).parse_local_variables(arguments)).to eq({ "a" => 10, "b" => 20 }) }
    it { expect(described_class.new(parameters, value, {}).call(arguments)).to eq(30) }
  end
end
