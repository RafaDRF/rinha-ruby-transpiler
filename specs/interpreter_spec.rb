require_relative '../src/interpreter'
require 'json'

describe Interpreter do
  let(:evaluate) { described_class.new.evaluate(formated_expression(ast_expression)) }

  context 'Tipos primitivos' do
    context 'Inteiro' do
      let(:ast_expression) do
        '{
          "kind": "Int",
          "value": 3
        }'
      end

      it { expect(evaluate).to eq(3) }
    end

    context 'Bool' do
      let(:ast_expression) do
        '{
          "kind": "Bool",
          "value": true
        }'
      end

      it { expect(evaluate).to eq(true) }
    end

    context 'String' do
      let(:ast_expression) do
        '{
          "kind": "Str",
          "value": "palavra usada"
        }'
      end

      it { expect(evaluate).to eq('palavra usada') }
    end
  end

  context 'Tipo Tupla' do
    context 'Inicialização' do
      # Codigo em .rinha:
      #
      # (3, 4)

      let(:ast_expression) do
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

    context 'Função First' do
      # Codigo em .rinha:
      #
      # first((1, 2))

      let(:ast_expression) do
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

    context 'Função Second' do
      # Codigo em .rinha:
      #
      # second((1, 2))

      let(:ast_expression) do
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
  end

  context 'Operação binária' do
    context 'Adição de Inteiros' do
      # Codigo em .rinha:
      #
      # 3 + 2

      let(:ast_expression) do
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

    context 'Concatenação de Inteiro e String' do
      # Codigo em .rinha:
      #
      # "a" + 2

      let(:ast_expression) do
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

    context 'Subtração de Inteiros' do
      # Codigo em .rinha:
      #
      # 3 - 7

      let(:ast_expression) do
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

    context 'Multiplicação de Inteiros' do
      # Codigo em .rinha:
      #
      # 5 * 7

      let(:ast_expression) do
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

    context 'Divisão de Inteiros' do
      # Codigo em .rinha:
      #
      # 4 / 2

      let(:ast_expression) do
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

    context 'Resto da divisão' do
      # Codigo em .rinha:
      #
      # 4 % 2

      let(:ast_expression) do
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

    context 'Igualdade' do
      # Codigo em .rinha:
      #
      # "a" == "a"

      let(:ast_expression) do
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

    context 'Diferença' do
      # Codigo em .rinha:
      #
      # "a" != "a"

      let(:ast_expression) do
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

    context 'Menor que' do
      # Codigo em .rinha:
      #
      # 1 < 2

      let(:ast_expression) do
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

    context 'Maior que' do
      # Codigo em .rinha:
      #
      # 2 > 3

      let(:ast_expression) do
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

    context 'Menor ou igual' do
      # Codigo em .rinha:
      #
      # 5 <= 7

      let(:ast_expression) do
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

    context 'Maior ou igual' do
      # Codigo em .rinha:
      #
      # 5 >= 7

      let(:ast_expression) do
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

    context 'Operador lógico E' do
      # Codigo em .rinha:
      #
      # true && false

      let(:ast_expression) do
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

    context 'Operador lógico OU' do
      # Codigo em .rinha:
      #
      # true || false

      let(:ast_expression) do
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
  end

  context 'Print' do
    context 'String como entrada' do
      # Codigo em .rinha:
      #
      # print("alguma coisa")

      let(:ast_expression) do
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

    context 'Tupla como entrada' do
      # Codigo em .rinha:
      #
      # print((2, 4))

      let(:ast_expression) do
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
  end

  context 'Condicional' do
    # Codigo em .rinha:
    #
    # if (true) {
    #   1
    # } else {
    #   2
    # }

    let(:ast_expression) do
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

  context 'Atribuição' do
    # Codigo em .rinha:
    #
    # Let a = 1
    #
    # a

    let(:ast_expression) do
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

  context 'Atribuição e operação binária' do
    # Codigo em .rinha:
    #
    # Let a = 1
    # Let b = 2
    #
    # a + b

    let(:ast_expression) do
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

  context 'Clousure' do
    context 'simples' do
      # Codigo em .rinha:
      #
      #  let soma = fn(a, b) => {
      #     a + b
      #  };
      #
      # soma(10, 20)

      let(:ast_expression) do
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

    context 'recursivo' do
      # Codigo em .rinha:
      #
      # let recur = fn(a) => {
      # if(a < 2) {
      #   a
      # }
      # else {
      #   recur(a - 1) + a
      # }
      # };

      # recur(2)

      let(:ast_expression) do
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

    context 'fibonacci recursivo de 10' do
      # Codigo em .rinha:
      #
      # let fib = fn (n) => {
      #   if (n < 2) {
      #     n
      #   } else {
      #     fib(n - 1) + fib(n - 2)
      #   }
      # };
      #
      # fib(10)

      let(:ast_expression) do
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
end

def formated_expression(string_json)
  JSON.parse(string_json, symbolize_names: true)
end
