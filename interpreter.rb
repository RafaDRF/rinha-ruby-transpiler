require_relative 'tuple'
require_relative 'closure'
class Interpreter
  def initialize
    @local_variables = {}
    @closures_variables = []
  end

  attr_accessor :local_variables, :closures_variables

  def evaluate(expression)
    case expression[:kind]
    when 'Binary'
      binary_exp(evaluate(expression[:lhs]), expression[:op], evaluate(expression[:rhs]))
    when 'Print'
      puts evaluate(expression[:value])
    when 'Tuple'
      Tuple.new(evaluate(expression[:first]), evaluate(expression[:second]))
    when 'First'
      evaluate(expression[:value]).first
    when 'Second'
      evaluate(expression[:value]).second
    when 'If'
      evaluate(expression[:condition]) ? evaluate(expression[:then]) : evaluate(expression[:otherwise])
    when 'Let'
      local_variables.merge!({ expression[:name][:text] => evaluate(expression[:value]) })
      evaluate(expression[:next])
    when 'Var'
      local_variables[expression[:text]] || closures_variables.last[expression[:text]]
    when 'Function'
      Closure.new(expression[:parameters], expression[:value], local_variables)
    when 'Call'
      evaluate(expression[:callee]).call(self, expression[:arguments])
    else
      expression[:value]
    end
  end

  def evaluate_closure(value)
    closure_value = evaluate(value)
    closures_variables.pop
    closure_value
  end

  def binary_exp(lhs, operation, rhs)
    sides = [lhs, rhs]

    sides.map!(&:to_s) if operation == 'Add' && sides.any?(String)

    sides.reduce(OPERATIONS_MAP[operation.to_sym])
  end

  OPERATIONS_MAP = {
    Add: :+,
    Sub: :-,
    Mul: :*,
    Div: :/,
    Rem: :%,
    Eq: :==,
    Neq: :!=,
    Lt: :<,
    Gt: :>,
    Lte: :<=,
    Gte: :>=,
    And: :&,
    Or: :|
  }.freeze
end
