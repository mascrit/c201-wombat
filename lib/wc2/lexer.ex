#!/usr/bin/escript
# -*- coding: utf-8 -*-

defmodule Wc2.Lexer do
  @moduledoc """
  Analizador Léxico
  """

  @doc """
  La funcion sanitizer borra los espacios en un archivo o cadena
  """
  def sanitizer(file) do
    file_whitout_spaces = String.trim(file)
    {:ok, Regex.split(~r/\s+/, file_whitout_spaces)}
  end
  
  @doc """
  Lee un archivo y devuelve una lista de tokens
  """
  def scanner_words(file_whitout_spaces) do

    tuple = Enum.flat_map(file_whitout_spaces, &lexer_raw_tokens/1)
    if {:error, "misspeled in 'return'"} in tuple do
      {:error, "misspeled in 'return'"}
    else
      {:ok,tuple}
    end
  end
  
  def get_constant(prog) do
    case Regex.run(~r/\d+/,prog) do
      [value] -> {{:const, String.to_integer(value)},
		 String.trim_leading(prog,value)}
      _ -> {:error, "constan error"}
    end
  end

  def lexer_raw_tokens(prog) when prog != "" do
    {token, rest} =
      case prog do
        "int"<> rest -> {:kint, rest}
        "main"<> rest -> {:kmain, rest}
	"(" <> rest -> {:open_paren, rest}
	")" <> rest -> {:close_paren, rest}
        "{"<> rest -> {:open_brace, rest}
        "}"<> rest -> {:close_brace, rest}
        "return" <> rest ->
	  if "return"<>rest == "return" do
	    {:kreturn, rest}
	  else
	    {:error, "misspeled in 'return'"}

	  end
            ";"<> rest -> {:semicolon, rest}
        rest -> get_constant(rest)
      end
    if token == :error do
      [{token, rest}]
    else
      remaining_tokens =lexer_raw_tokens(rest)
    
      [token | remaining_tokens]
    end
  end
  

  def lexer_raw_tokens(_rest) do
    []
  end


end
