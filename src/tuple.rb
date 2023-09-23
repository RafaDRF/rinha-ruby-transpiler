class Tuple
  def initialize(first, second)
    @first = first
    @second = second
  end

  attr_reader :first, :second

  def to_s
    "(#{first}, #{second})"
  end

  def ==(other)
    other.first == first && other.second == second
  end
end
