require_relative 'interpreter'
require 'json'

describe Interpreter do
  let(:evaluate) { described_class.new.evaluate(formated_expression(json_string)) }

  context 'Inteiro' do
    let(:json_string) do
      '{
        "kind": "Int",
        "value": 3
      }'
    end

    it { expect(evaluate).to eq(3) }
  end

  context 'Bool' do
    let(:json_string) do
      '{
        "kind": "Bool",
        "value": true
      }'
    end

    it { expect(evaluate).to eq(true) }
  end

  context 'String' do
    let(:json_string) do
      '{
        "kind": "Str",
        "value": "palavra usada"
      }'
    end

    it { expect(evaluate).to eq('palavra usada') }
  end

  context 'Add Soma 3 + 2' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 3
        },
        "op": "Add",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evaluate).to eq(5) }
  end

  context 'Add Concatenacao "a" + 2' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Str",
          "value": "a"
        },
        "op": "Add",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evaluate).to eq('a2') }
  end

  context 'Sub' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 3
        },
        "op": "Sub",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evaluate).to eq(-4) }
  end

  context 'Mul' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 5
        },
        "op": "Mul",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evaluate).to eq(35) }
  end

  context 'Div' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 4
        },
        "op": "Div",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evaluate).to eq(2) }
  end

  context 'Rem' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 4
        },
        "op": "Rem",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evaluate).to eq(0) }
  end

  context 'Igualdade  "a" == "a"' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Str",
          "value": "a"
        },
        "op": "Eq",
        "rhs": {
          "kind": "Str",
          "value": "a"
        }
      }'
    end

    it { expect(evaluate).to eq(true) }
  end

  context 'Diferente  "a" != "a"' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Str",
          "value": "a"
        },
        "op": "Neq",
        "rhs": {
          "kind": "Str",
          "value": "a"
        }
      }'
    end

    it { expect(evaluate).to eq(false) }
  end

  context 'Menor  1 < 2' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 1
        },
        "op": "Lt",
        "rhs": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evaluate).to eq(true) }
  end

  context 'Maior  2 > 3' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 2
        },
        "op": "Gt",
        "rhs": {
          "kind": "Int",
          "value": 3
        }
      }'
    end

    it { expect(evaluate).to eq(false) }
  end

  context 'Menor ou igual 5 <= 7' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 5
        },
        "op": "Lte",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evaluate).to eq(true) }
  end

  context 'Maior ou igual 5 >= 7' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Int",
          "value": 5
        },
        "op": "Gte",
        "rhs": {
          "kind": "Int",
          "value": 7
        }
      }'
    end

    it { expect(evaluate).to eq(false) }
  end

  context 'And true && false' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Bool",
          "value": true
        },
        "op": "And",
        "rhs": {
          "kind": "Bool",
          "value": false
        }
      }'
    end

    it { expect(evaluate).to eq(false) }
  end

  context 'Or true || false' do
    let(:json_string) do
      '{
        "kind": "Binary",
        "lhs": {
          "kind": "Bool",
          "value": true
        },
        "op": "Or",
        "rhs": {
          "kind": "Bool",
          "value": false
        }
      }'
    end

    it { expect(evaluate).to eq(true) }
  end

  context 'print("alguma coisa")' do
    let(:json_string) do
      '{
        "kind": "Print",
        "value": {
          "kind": "Str",
          "value": "alguma coisa"
        }
      }'
    end

    it { expect { evaluate }.to output("alguma coisa\n").to_stdout }
  end

  context 'print((2, 4))' do
    let(:json_string) do
      '{
        "kind": "Print",
        "value": {
          "kind": "Tuple",
          "first": {
            "kind": "Int",
            "value": 2
          },
          "second": {
            "kind": "Int",
            "value": 4
          }
        }
      }'
    end

    it { expect { evaluate }.to output("(2, 4)\n").to_stdout }
  end

  context 'Tuple (3, 4)' do
    let(:json_string) do
      '{
        "kind": "Tuple",
        "first": {
          "kind": "Int",
          "value": 3
        },
        "second": {
          "kind": "Int",
          "value": 4
        }
      }'
    end

    it { expect(evaluate).to eq(Tuple.new(3, 4)) }
  end

  context 'first((1, 2))' do
    let(:json_string) do
      '{
        "kind": "First",
        "value": {
          "kind": "Tuple",
          "first": {
            "kind": "Int",
            "value": 1
          },
          "second": {
            "kind": "Int",
            "value": 2
          }
        }
      }'
    end

    it { expect(evaluate).to eq(1) }
  end

  context 'second((1, 2))' do
    let(:json_string) do
      '{
        "kind": "Second",
        "value": {
          "kind": "Tuple",
          "first": {
            "kind": "Int",
            "value": 1
          },
          "second": {
            "kind": "Int",
            "value": 2
          }
        }
      }'
    end

    it { expect(evaluate).to eq(2) }
  end

  context 'if' do
    let(:json_string) do
      '{
        "kind": "If",
        "condition": {
          "kind": "Bool",
          "value": true
        },
        "then": {
          "kind": "Int",
          "value": 1
        },
        "otherwise": {
          "kind": "Int",
          "value": 2
        }
      }'
    end

    it { expect(evaluate).to eq(1) }
  end

  context 'Atribuição Let a = 1' do
    let(:json_string) do
      '{
        "kind": "Let",
        "name": {
          "text": "a"
        },
        "value": {
          "kind": "Int",
          "value": 4
        },
        "next": {
          "kind": "Var",
          "text": "a"
        }
      }'
    end

    it { expect(evaluate).to eq(4) }
  end

  context 'Atribuição Let a = 1; Let b = 2; a + b' do
    let(:json_string) do
      '{
        "kind": "Let",
        "name": {
          "text": "a"
        },
        "value": {
          "kind": "Int",
          "value": 1
        },
        "next": {
          "kind": "Let",
          "name": {
            "text": "b"
          },
          "value": {
            "kind": "Int",
            "value": 2
          },
          "next": {
            "kind": "Binary",
            "lhs": {
              "kind": "Var",
              "text": "a"
            },
            "op": "Add",
            "rhs": {
              "kind": "Var",
              "text": "b"
            }
          }
        }
      }'
    end

    it { expect(evaluate).to eq(3) }
  end

  context 'let soma = fn(a, b) => {
              a + b
          };

          soma(10, 20)' do
    let(:json_string) do
      '{
        "kind": "Let",
        "name": {
          "text": "soma"
        },
        "value": {
          "kind": "Function",
          "parameters": [
            {
              "text": "a"
            },
            {
              "text": "b"
            }
          ],
          "value": {
            "kind": "Binary",
            "lhs": {
              "kind": "Var",
              "text": "a"
            },
            "op": "Add",
            "rhs": {
              "kind": "Var",
              "text": "b"
            }
          }
        },
        "next": {
          "kind": "Call",
          "callee": {
            "kind": "Var",
            "text": "soma"
          },
          "arguments": [
            {
              "kind": "Int",
              "value": 10
            },
            {
              "kind": "Int",
              "value": 20
            }
          ]
        }
      }'
    end

    it { expect(evaluate).to eq(30) }
  end

  context 'recursão' do
=begin
let recur = fn(a) => {
  if(a < 2) {
    a
  }
  else {
    recur(a - 1) + a
  }
};

recur(2)
=end
    let(:json_string) do
      '{
        "kind": "Let",
        "name": {
          "text": "recur"
        },
        "value": {
          "kind": "Function",
          "parameters": [
            {
              "text": "a"
            }
          ],
          "value": {
            "kind": "If",
            "condition": {
              "kind": "Binary",
              "lhs": {
                "kind": "Var",
                "text": "a"
              },
              "op": "Lt",
              "rhs": {
                "kind": "Int",
                "value": 2
              }
            },
            "then": {
              "kind": "Var",
              "text": "a"
            },
            "otherwise": {
              "kind": "Binary",
              "lhs": {
                "kind": "Call",
                "callee": {
                  "kind": "Var",
                  "text": "recur"
                },
                "arguments": [
                  {
                    "kind": "Binary",
                    "lhs": {
                      "kind": "Var",
                      "text": "a"
                    },
                    "op": "Sub",
                    "rhs": {
                      "kind": "Int",
                      "value": 1
                    }
                  }
                ]
              },
              "op": "Add",
              "rhs": {
                "kind": "Var",
                "text": "a"
              }
            }
          }
        },
        "next": {
          "kind": "Call",
          "callee": {
            "kind": "Var",
            "text": "recur"
          },
          "arguments": [
            {
              "kind": "Int",
              "value": 2
            }
          ]
        }
      }'
    end

    it { expect(evaluate).to eq(3) }
  end

  context 'fibonacci recursivo' do
=begin
let fib = fn (n) => {
  if (n < 2) {
    n
  } else {
    fib(n - 1) + fib(n - 2)
  }
};

fib(10)
=end

    let(:json_string) do
      '{
        "kind": "Let",
        "name": {
          "text": "fib"
        },
        "value": {
          "kind": "Function",
          "parameters": [
            {
              "text": "n"
            }
          ],
          "value": {
            "kind": "If",
            "condition": {
              "kind": "Binary",
              "lhs": {
                "kind": "Var",
                "text": "n"
              },
              "op": "Lt",
              "rhs": {
                "kind": "Int",
                "value": 2
              }
            },
            "then": {
              "kind": "Var",
              "text": "n"
            },
            "otherwise": {
              "kind": "Binary",
              "lhs": {
                "kind": "Call",
                "callee": {
                  "kind": "Var",
                  "text": "fib"
                },
                "arguments": [
                  {
                    "kind": "Binary",
                    "lhs": {
                      "kind": "Var",
                      "text": "n"
                    },
                    "op": "Sub",
                    "rhs": {
                      "kind": "Int",
                      "value": 1
                    }
                  }
                ]
              },
              "op": "Add",
              "rhs": {
                "kind": "Call",
                "callee": {
                  "kind": "Var",
                  "text": "fib"
                },
                "arguments": [
                  {
                    "kind": "Binary",
                    "lhs": {
                      "kind": "Var",
                      "text": "n"
                    },
                    "op": "Sub",
                    "rhs": {
                      "kind": "Int",
                      "value": 2
                    }
                  }
                ]
              }
            }
          }
        },
        "next": {
          "kind": "Call",
          "callee": {
            "kind": "Var",
            "text": "fib"
          },
          "arguments": [
            {
              "kind": "Int",
              "value": 10
            }
          ]
        }
      }'
    end

    it { expect(evaluate).to eq(55) }
  end
end

def formated_expression(string_json)
  JSON.parse(string_json, symbolize_names: true)
end
