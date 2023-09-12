require 'json'
require_relative 'interpreter'

file = File.read('/var/ast.json')

data_hash = JSON.parse(file, symbolize_names: true)

Interpreter.evalue data_hash[:expression]
