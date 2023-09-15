require_relative 'interpreter'
require 'json'
class Closure
  def initialize(parameters, value, local_variables)
    @parameters = parameters
    @value = value
    @local_variables = Hash.new(local_variables)
  end

  attr_accessor :parameters, :value, :local_variables

  def call(arguments)
    interpreter = Interpreter.new local_variables.merge(parse_local_variables(arguments))
    interpreter.evaluate(value)
  end

  def parse_local_variables(arguments)
    varibles = {}

    arguments.each_with_index do |a, index|
      varibles.merge!({ parameters[index][:text] => a })
    end
    varibles
  end
end
