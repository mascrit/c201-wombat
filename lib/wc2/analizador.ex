#!/usr/bin/escript
# -*- coding: utf-8 -*-

defmodule Wc2.Analizador do

  def parse_program(list_token) do

    function = parse_function(list_token)
    case function do
      {{:error, message}, _tail} ->
        {:error, message}

      {nodefun, rest_list} ->
        case rest_list do
          [] ->
	    %Arbol{node: :program, lleaf: nodefun}
          _ -> {:error, "Error more elements"}
        end
    end
  end

  def parse_function(list_token) do
    #IO.inspect(hd(list_token))
    if (hd(list_token)) == :kint do
      rest_list = list_token |> tl()
      if hd(rest_list) == :kmain do
        rest_list = tl(rest_list)
        if hd(rest_list) == :open_paren do
          rest_list = tl(rest_list)
          if hd(rest_list) == :close_paren do
            rest_list = tl(rest_list)
	    #IO.inspect(rest_list)

            if hd(rest_list) == :open_brace do
              statement = parse_statement(tl(rest_list))
	      
	      case statement do
		{{:error, error_message}, rest_list} ->
                  {{:error, error_message}, tl(rest_list)}

		{statement_node, rest_list} ->
		  cond do
		    hd(rest_list) == :close_brace ->
		      {%Arbol{node: :function,
			      val: :main, lleaf: statement_node},
		       tl(rest_list)}
		    :true ->
		      {{:error, "close brace?"}, tl(rest_list)}
		  end

              end
	    else
	      {:error, "open brace?"}
            end
	  else
	    {:error, "close parentesis?"}
          end
	else
	  {:error, "open parentesis?"}
	end
      else
	{:error, "main lost?"}
      end
    else
      {:error, "type of function lost"}
    end
  end

  def parse_statement(list_token) do
    tail = tl(list_token)
    if hd(list_token) == :kreturn do
      expression = parse_expression(tail)
      
      case expression do
        {{:error, message}, tail} ->
	  {{:error, message}, tail}

	{expression_node, list_token} ->
	  cond do
	    hd(list_token) == :semicolon ->
	      tail = tl(tail)
	      #IO.inspect(tail)
	      {%Arbol{node: :kreturn, lleaf: expression_node}, tl(tail)}
	    :true -> {{:error, "semicolon missed"}, tail}
	  end
      end
    else
      {{:error, "return?"}, tail}
    end
  end

  def parse_expression(list_token) do
    case hd(list_token) do
      {:const, val} ->
	tail=tl(list_token)
        {%Arbol{node: :const, val: val}, tail}
      _ -> {{:error, "Value?"}, tl(list_token)}
    end
  end

end
