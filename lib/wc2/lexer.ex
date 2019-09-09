#!/usr/bin/escript
# -*- coding: UTF-8 -*-

defmodule Wc2.Lexer do
  @moduledoc """
  Analizador Léxico
  """

  @doc """
  Lee un archivo y devuelve una lista de tokens
  """
  @spec lexer(String.t(),integer)::list 
    def lexer(tokens, numero_linea) do
      
      clave=keywords()
      const=~r(^[0-9]+)
      espacio=~r(^[ \h]+)
      linea=~r(^[\n\\|\r\n])
      cadena_caracter=~r/^"(?:[""\\]|\\.)*"/

      cond do
    
        tokens==""->[]
        Regex.match?(espacio,tokens)->lexer(Regex.replace(espacio,tokens,""),num_linea)
        Regex.match?(linea,tokens)->lexer(Regex.replace(espacio,tokens,""),num_linea+1)
        Regex.match?(cadena_caracter,tokens)->string=List.first(Regex.run(cadena_caracter,tokens,[{:capture,:first}]))
        token={:ident,num_linea,[id]}

      end 
    end
    def devuelve_token(token) do
      case token do 
        {:type,:kint}->"int"
        {:kmain}->"main()"
        {:open_paren}->"("
        {:close_paren}->")"
        {:open_brace}->"{"
        {:kreturn}->"return"
        {:const, 2}->"2"
        {:semicolon}->";"
        {:close_brance}->"}"   
      
      end
                
    end