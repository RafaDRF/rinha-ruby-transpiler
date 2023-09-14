require 'json'
require_relative 'interpreter'

file = File.read('/var/rinha/source.rinha.json')

data_hash = JSON.parse(file, symbolize_names: true)

Interpreter.new.evaluate data_hash[:expression]
