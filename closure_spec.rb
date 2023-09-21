require_relative 'closure'
require_relative 'interpreter'

describe Closure do
  context '#parse_local_variables' do
    let(:parameters) do
      [{ text: 'a', location: { start: 14, end: 15, filename: 'source.rinha' } },
       { text: 'b', location: { start: 17, end: 18, filename: 'source.rinha' } }]
    end

    let(:arguments) do
      [{:kind=>"Int", :value=>10}, {:kind=>"Int", :value=>20}]
    end

    let(:value) do
      { kind: 'Binary', lhs: { kind: 'Var', text: 'a', location: { start: 29, end: 30, filename: 'source.rinha' } },
        op: 'Add', rhs: { kind: 'Var', text: 'b', location: { start: 33, end: 34, filename: 'source.rinha' } } }
    end

    let(:interpreter) { Interpreter.new }

    it { expect(described_class.new(parameters, value, {}).call(interpreter, arguments)).to eq(30) }
  end
end
