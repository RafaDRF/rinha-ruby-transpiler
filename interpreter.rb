require_relative 'tuple'
require_relative 'closure'
class Interpreter
  def initialize(local_variables = {})
    @local_variables = local_variables
  end

  attr_accessor :local_variables

  def evaluate(expression)
    case expression[:kind]
    when 'Binary'
      lhs = evaluate(expression[:lhs])
      loop do
        break if lhs.is_a?(Numeric) || lhs.respond_to?(:to_str) || lhs == true || lhs == false

        lhs = evaluate(lhs)
      end

      rhs = evaluate(expression[:rhs])
      loop do
        break if rhs.is_a?(Numeric) || rhs.respond_to?(:to_str) || rhs == true || rhs == false

        rhs = evaluate(rhs)
      end

      return binary_exp(lhs, expression[:op], rhs)
    when 'Print'
      return puts evaluate(expression[:value])
    when 'Tuple'
      return Tuple.new(evaluate(expression[:first]), evaluate(expression[:second]))
    when 'First'
      return evaluate(expression[:value]).first
    when 'Second'
      return evaluate(expression[:value]).second
    when 'If'
      return evaluate(expression[:condition]) ? evaluate(expression[:then]) : evaluate(expression[:otherwise])
    when 'Let'
      local_variables.merge!({ expression[:name][:text] => evaluate(expression[:value]) })
      return evaluate(expression[:next])
    when 'Var'
      return local_variables[expression[:text]]
    when 'Function'
      return Closure.new(expression[:parameters], expression[:value], local_variables)
    when 'Call'
      return evaluate(expression[:callee]).call(expression[:arguments])
    end

    expression[:value]
  end

  def binary_exp(lhs, op, rhs)
    case op
    when 'Add'
      [lhs, rhs].all?(Numeric) ? lhs + rhs : lhs.to_s + rhs.to_s
    when 'Sub'
      lhs - rhs
    when 'Mul'
      lhs * rhs
    when 'Div'
      lhs / rhs
    when 'Rem'
      lhs % rhs
    when 'Eq'
      lhs == rhs
    when 'Neq'
      lhs != rhs
    when 'Lt'
      lhs < rhs
    when 'Gt'
      lhs > rhs
    when 'Lte'
      lhs <= rhs
    when 'Gte'
      lhs >= rhs
    when 'And'
      lhs && rhs
    when 'Or'
      lhs || rhs
    end
  end
end

class Clous
  
end