defmodule ParserTest do
  use ExUnit.Case
  import Parser

  # Teste 1: Verifica se o parser consegue analisar um programa simples com uma única atribuição.
  test "Teste 1" do
    tokens = [
      {:keyword, "program"}, {:id, "ProgramOne"}, {:ponto_virgula, ";"},
      {:id, "a"}, {:operator, ":="}, {:integer, 7},
      {:keyword, "end"}
    ]

    ast = parse(tokens)
    expected_ast = {:prog, "ProgramOne", {:assign, "a", {:integer, 7}}}
    assert ast == expected_ast
  end

  # Teste 2: Verifica se o parser consegue analisar um programa com um bloco begin-end contendo múltiplas atribuições.
  test "Teste 2" do
    tokens = [
      {:keyword, "program"}, {:id, "ProgramTwo"}, {:ponto_virgula, ";"},
      {:keyword, "begin"},
        {:id, "b"}, {:operator, ":="}, {:integer, 15}, {:semicolon, ";"},
        {:id, "c"}, {:operator, ":="}, {:id, "b"}, {:operator, "+"}, {:integer, 25},
      {:keyword, "end"},
      {:keyword, "end"}
    ]

    ast = parse(tokens)
    expected_ast = {:prog, "ProgramTwo", {:begin_end, [
      {:assign, "b", {:integer, 15}},
      {:assign, "c", {:operator, "+", {:id, "b"}, {:integer, 25}}}
    ]}}
    assert ast == expected_ast
  end

  # Teste 3: Verifica se o parser consegue analisar um programa com uma estrutura condicional if-then-else.
  test "Teste 3" do
    tokens = [
      {:keyword, "program"}, {:id, "ProgramThree"}, {:ponto_virgula, ";"},
      {:keyword, "if"}, {:id, "z"}, {:operator, "<"}, {:integer, 100},
      {:keyword, "then"},
        {:id, "a"}, {:operator, ":="}, {:integer, 10},
      {:keyword, "else"},
        {:id, "a"}, {:operator, ":="}, {:integer, 20},
      {:keyword, "end"}
    ]

    ast = parse(tokens)
    expected_ast = {:prog, "ProgramThree", {:if, {:operator, "<", {:id, "z"}, {:integer, 100}},
      {:assign, "a", {:integer, 10}},
      {:assign, "a", {:integer, 20}}
    }}
    assert ast == expected_ast
  end
end
