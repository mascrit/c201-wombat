defmodule CompiladorwombatTest do
  use ExUnit.Case
  doctest Compiladorwombat

  # test "greets the world" do
  #   assert Compiladorwombat.hello() == :world
  # end

  test "Exec parser" do
    assert Wc2.Analizador.test(
      [:kint,
       :kmain,
       :open_paren,
       :close_paren,
       :open_brace,
       :kreturn,
       {:const, 2},
       :semicolon,
       :close_brace]) == :ok
  end
end
