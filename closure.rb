require_relative 'interpreter'
require 'json'
class Closure
  def initialize(parameters, value, local_variables)
    @parameters = parameters
    @value = value
    @local_variables = Hash.new(local_variables)
  end

  attr_accessor :parameters, :value, :local_variables

  def call(interpreter, arguments)
    interpreter.closures_variables << parse_local_variables(interpreter, arguments)
    interpreter.evaluate_closure(value)
  end

  def parse_local_variables(interpreter, arguments)
    variables = {}

    arguments.each_with_index do |a, index|
      variables.merge!({ parameters[index][:text] => interpreter.evaluate(a) })
    end

    variables
  end
end
