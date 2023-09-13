class Interpreter
  def self.evaluate(expression, local_variables={})
    case expression[:kind]
    when 'Binary'
      return binary_exp(evaluate(expression[:lhs], local_variables), expression[:op], evaluate(expression[:rhs], local_variables))
    when 'Print'
      return print evaluate(expression[:value], local_variables)
    when 'Tuple'
      return [evaluate(expression[:first], local_variables), evaluate(expression[:second], local_variables)]
    when 'First'
      return evaluate(expression[:value], local_variables).first
    when 'Second'
      return evaluate(expression[:value], local_variables).last
    when 'If'
      return evaluate(expression[:condition], local_variables) ? evaluate(expression[:then], local_variables) : evaluate(expression[:otherwise], local_variables)
    when 'Let'
      return evaluate(expression[:next], local_variables.merge({ expression[:name][:text] => evaluate(expression[:value], local_variables) }))
    when 'Var'
      return local_variables[expression[:text]]
    end

    expression[:value]
  end

  def self.binary_exp(lhs, op, rhs)
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
