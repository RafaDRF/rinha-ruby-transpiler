class Interpreter
  def self.evalue(expression)
    case expression[:kind]
    when 'Binary'
      return binary_exp(evalue(expression[:lhs]), expression[:op], evalue(expression[:rhs]))
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
    end
  end
end
