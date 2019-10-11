defmodule LexerTest do
  use ExUnit.Case
  doctest Wc2.Lexer

  setup_all do
    {:ok,
     tokens: {:ok, [
       :kint,
       :kmain,
       :open_paren,
       :close_paren,
       :open_brace,
       :kreturn,
       {:const, 2},
       :semicolon,
       :close_brace
     ]},
     tokens_0: {:ok, [
       :kint,
       :kmain,
       :open_paren,
       :close_paren,
       :open_brace,
       :kreturn,
       {:const, 0},
       :semicolon,
       :close_brace
     ]},
     tokens_100: {:ok,[
       :kint,
       :kmain,
       :open_paren,
       :close_paren,
       :open_brace,
       :kreturn,
       {:const, 100},
       :semicolon,
       :close_brace
     ]}}
  end

  # test "return 2", state do
  #   code = """
  #   int main(){
  #     return 2;
  #   }
  #   """
  #   with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
  #     assert IO.inspect( Wc2.Lexer.scanner_words(something))
  #   end
  # end
  
  test "multidigit", state do
    code = File.read!("test/stage_1/valid/multi_digit.c")
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:tokens_100]
    end
  end

  test "newlines", state do
    code = File.read!("test/stage_1/valid/newlines.c")
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:tokens_0]
    end
  end
  
  test "no newlines", state do
    code = File.read!("test/stage_1/valid/no_newlines.c")
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:tokens_0]
    end
  end
  
  test "return 0", state do
    code = File.read!("test/stage_1/valid/return_0.c")
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:tokens_0]
    end
  end

  test "return 2", state do
    code = File.read!("test/stage_1/valid/return_2.c")
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:tokens]
    end
  end
  test "space ", state do
    code = File.read!("test/stage_1/valid/spaces.c")
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:tokens_0]
    end
  end
  
  
end
