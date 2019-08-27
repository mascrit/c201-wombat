#!/usr/bin/elixir
# -*- coding: UTF-8 -*-

defmodule Wlexer.Lexer do
  @moduledoc """
  Analizador Léxico
  """

  defp tokenize(chr = [ch | rest], tokens) do
    cond do
      es_espacio(ch) -> tokenize(rest, tokens)
    end
  end

  defp es_letra(ch) do
    ch =~ ~r/[[:alpha:]]/
  end

  defp es_espacio(ch) do
    ch == " " || ch == "\n" || ch == "\t"
  end

end
