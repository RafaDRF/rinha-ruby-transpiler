require_relative '../src/closure'
require_relative '../src/interpreter'

describe Closure do
  context '#call' do
    let(:parameters) do
      [{ text: 'a' },
       { text: 'b' }]
    end

    let(:value) do
      {
        kind: 'Binary',
        lhs: { kind: 'Var', text: 'a' },
        op: 'Add',
        rhs: { kind: 'Var', text: 'b' }
      }
    end

    let(:interpreter) { Interpreter.new }

    let(:arguments) do
      [{:kind => "Int", :value => 10}, {:kind => "Int", :value => 20}]
    end

    it { expect(described_class.new(parameters, value, {}).call(interpreter, arguments)).to eq(30) }
  end
end
