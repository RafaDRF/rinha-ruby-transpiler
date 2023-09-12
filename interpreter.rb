class Interpreter
  def self.evalue(expression)
    case expression[:kind]
    when 'Binary'
      return binary_exp(evalue(expression[:lhs]), expression[:op], evalue(expression[:rhs]))
    when 'Print'
      return print evalue(expression[:value])
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
