defmodule CompiladorwombatTest do
  use ExUnit.Case
  doctest Compiladorwombat

  # # test "greets the world" do
  # #   assert Compiladorwombat.hello() == :world
  # # end

  # # test "Exec parser" do
  # #   assert Wc2.Analizador.test(
  # #     [:kint,
  # #      :kmain,
  # #      :open_paren,
  # #      :close_paren,
  # #      :open_brace,
  # #      :kreturn,
  # #      {:const, 2},
  # #      :semicolon,
  # #      :close_brace]) == :ok
  # # end
  # test "valid multi digit" do
  #   assert Compiladorwombat.compile_file("test/stage_1/valid/multi_digit.c") == 0
  #  end

  # test "valid new lines" do
  #   assert Compiladorwombat.compile_file("test/stage_1/valid/newlines.c") == 0
  # end

  # test "valid no newlines" do
  #   assert Compiladorwombat.compile_file("test/stage_1/valid/no_newlines.c") == 0
  # end

  # test "valid return 0" do
  #   assert Compiladorwombat.compile_file("test/stage_1/valid/return_0.c") == 0
  # end

  # test "valid spaces" do
  #   assert Compiladorwombat.compile_file("test/stage_1/valid/spaces.c") == 0
  # end

  # test "invalid missing_paren" do
  #   assert Compiladorwombat.compile_file("test/stage_1/invalid/missing_paren.c") == 1
  # end

  # test "invalid missing_retval" do
  #   assert Compiladorwombat.compile_file("test/stage_1/invalid/missing_retval.c") == 1
  # end

  # test "invalid no_brace" do
  #   assert Compiladorwombat.compile_file("test/stage_1/invalid/no_brace.c") == 1
  # end

  # test "invalid no_semicolon" do
  #   assert Compiladorwombat.compile_file("test/stage_1/invalid/no_semicolon.c") == 1
  # end

  # test "invalid no_space" do
  #   assert Compiladorwombat.compile_file("test/stage_1/invalid/no_space.c") == 1
  # end

  # test "invalid wrong_case" do
  #   assert Compiladorwombat.compile_file("test/stage_1/invalid/wrong_case.c") == 1
  # end


end
