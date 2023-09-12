class Interpreter
  def self.evaluate(expression)
    case expression[:kind]
    when 'Binary'
      return binary_exp(evaluate(expression[:lhs]), expression[:op], evaluate(expression[:rhs]))
    when 'Print'
      return print evaluate(expression[:value])
    when 'Tuple'
      return [evaluate(expression[:first]), evaluate(expression[:second])]
    when 'First'
      return evaluate(expression[:value]).first
    when 'Second'
      return evaluate(expression[:value]).last
    when 'If'
      return evaluate(expression[:condition]) ? evaluate(expression[:then]) : evaluate(expression[:otherwise])
    end

    expression[:value]
  end

  def self.binary_exp(lhs, op, rhs)
    case op
    when 'Add'
      lhs + rhs
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
