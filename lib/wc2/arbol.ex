#!/usr/bin/escript
# -*- coding: UTF-8 -*-

defmodule Wc2.Arbol do
  @moduledoc"""
  Define la estructura del arbol de sintaxis abstracta
  """
  defstruct [:node, :val, :left, :right]

  
  @doc"""
  Print the elements of the structure
  """
  def print(tree) do
    cond do
      is_map(tree.left) ->
        print(tree.left)
        tree.node |> Atom.to_string |> IO.puts
      is_map(tree.right) ->
        print(tree.right)
        tree.node |> Atom.to_string |> IO.puts
      :true ->
        tree.node |> Atom.to_string |> IO.puts
        tree.node
    end
    
  end

end

end
