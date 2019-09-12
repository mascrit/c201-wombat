#!/usr/bin/escript
# -*- coding: UTF-8 -*-

defmodule Wc2.Arbol do
  @moduledoc"""
  Define la estructura del arbol de sintaxis
  abstracta
  """
  defstruct [:node, :val, :lleaf, :rleaf]


  @doc"""
  Print the elements of the structure
  """
  def print(tree) do
    cond do
      is_map(tree.lleaf) ->
        print(tree.lleaf)
        tree.node |> Atom.to_string |> IO.puts
      is_map(tree.rleaf) ->
        print(tree.rleaf)
        tree.node |> Atom.to_string |> IO.puts
	
      :true ->
        tree.node |> Atom.to_string |> IO.puts
        tree.node
    end

  end



end
