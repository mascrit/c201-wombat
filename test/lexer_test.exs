#!/usr/bin/elixir
# -*- coding: utf-8 -*-

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
		   ]},
     invtokens_paren: {:ok,
		       [
			 :kint,
			 :kmain,
			 :open_paren,
			 :open_brace,
			 :kreturn,
			 {:const, 0},
			 :semicolon,
			 :close_brace
		       ]},
     invtokens_m_retval: {:ok,
			  [
			    :kint,
			    :kmain,
			    :open_paren,
			    :close_paren,
			    :open_brace,
			    :kreturn,
			    :semicolon,
			    :close_brace
			  ]},
     invtokens_m_brace: {:ok, [
			    :kint,
			    :kmain,
			    :open_paren,
			    :close_paren,
			    :open_brace,
			    :kreturn,
			    {:const, 0},
			    :semicolon,
			  ]},
     invtokens_m_semicolon: {:ok, [
				:kint,
				:kmain,
				:open_paren,
				:close_paren,
				:open_brace,
				:kreturn,
				{:const, 0},
				:close_brace
			      ]},
     invtokens_m_space: {:ok,
			 [
			    :kint,
			    :kmain,
			    :open_paren,
			    :close_paren,
			    :identifier,
			    :close_brace
			  ]},
     invtoken_upcase: {:ok,
		       [
			    :kint,
			    :kmain,
			    :open_paren,
			    :close_paren,
			    :open_brace,
			    :identifier,
			    {:const, 0},
			    :close_brace
			]}
    }
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


  # -- Pruebas Válidas stage_1
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
  test "space", state do
    code = File.read!("test/stage_1/valid/spaces.c")
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:tokens_0]
    end
  end

  # -- Pruebas Inválidas stage_1

  test "missing paren", state do
    code = File.read!("test/stage_1/invalid/missing_paren.c")
    
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:invtokens_paren]
    end
  end

  test "missing retval", state do
    code = File.read!("test/stage_1/invalid/missing_retval.c")
    
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:invtokens_m_retval]
    end
  end

  test "no brace", state do
    code = File.read!("test/stage_1/invalid/no_brace.c")
    
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:invtokens_m_brace]
    end
  end

  test "no semicolon", state do
     code = File.read!("test/stage_1/invalid/no_semicolon.c")
    
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:invtoken_m_semicolon]
    end
  end

  test "no space", state do
     code = File.read!("test/stage_1/invalid/no_semicolon.c")
    
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:invtoken_m_space]
    end
  end

  test "wrong case", state do
     code = File.read!("test/stage_1/invalid/wrong_case.c")
    
    with {:ok, something} <- Wc2.Lexer.sanitizer(code) do
      assert Wc2.Lexer.scanner_words(something)==state[:invtoken_upcase]
    end
  end
  
end
