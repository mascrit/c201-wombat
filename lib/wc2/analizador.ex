##!/usr/bin/escript
# -*- coding: UTF-8 -*-

defmodule Wc2.Arbol do
  @moduledoc"""
  Define la estructura del arbol de sintaxis abstracta
  """
  defstruct [:nodo, :val, :inodo, :dnodo]
end

defmodule Wc2.Analizador do
  @moduledoc """
  Analizador de tokens
  """

  


  @doc"""
  Analiza el bloque funcional del programa

  ## Parametros
  
	  - tokens: Recibe una lista de tokens

  """
  def analizar_programa(tokens) do

    bloque_funcional = token |> analizar_bloque()

    case bloque_funcional do
      {{:bad, em}, cola} -> {:bad, em}

      {bloque_funcional, cola} ->
	if cola == [] do
	  %Arbol{nodo: :programa, inodo: bloque_nodo}
	else
	  {:bad, "elementos de mas"}
	end
    end
  end

  @doc"""
  Analiza el floque funcional validando si los tokens están
  en orden

  ## Parámetros:
  
	- [siguiente_t | cola]:  Recibe una lista de tokens donde
	    - siguiente_t se queda con la primera palabra y 
	    - cola se queda con el resto de la lista
  """
  def analizar_bloque([siguiente_t | cola]) do
    if siguiente_t == :KINT do
      [siguiente_t | cola] = cola

      if siguiente_t == :KMAIN do
	[siguiente_t | cola] = cola

	if siguiente_t == :DPARENTECIS do
	  [siguiente_t | cola] = cola
	  
	  if siguiente_t == :IPARENTECIS do

	    if siguiente_t == :DCORCHETE do
	      sentencia = cola |> analizar_sentencia()

	      case sentencia do
		{{:bad, m}, cola} -> {{:bad, m}, cola}

		{sentencia_n, [siguiente_t | cola]} ->
		  if siguiente_t == :ICORCHETE do
		    {%Arbol{nodo: :KBLOQUE, val: :KMAIN, inodo: sentencia_n}, cola}
		  else
		    {{:bad, "parentesis no encontrado"}, cola}
		  end
	      end
	    else {:bad, "corchete abierto perdido"}
	    end
	  else {:bad, "Parentesis no encontrado"}
	  end
	else {:bad, "Parentesis abierto perdido"}
	end
      else {:bad, "'main' perdido"}
      end
    else {:bad, "return perdido"}
    end
  end

  @doc"""
  Auxiliar para analizar la función

  ## Parametros

	- [siguiente_t | cola]: Recibe una lista de tokens donde
	    - siguiente_t se queda con la primera palabra y 
	    - cola se queda con el resto de la lista
  """
  def analizar_sentencia([siguiente_t | cola]) do
    if siguiente_t == :KRET do
      linea = cola |> fn [siguiente_t | cola] ->
	case siguiente_t do
	  {:CONST, valor} -> {%Arbol{nodo: :CONST, val: valot}, cola}
	  _ -> {{:bad, "contante no encontrado"}}
	end
      end

      case linea do
	{{:bad, em}, cola} -> {{:bad, em}, cola}

	{enodo, [siguiente_t | cola]} ->
	  if siguiente_t == :PCOMA do
	    {%Arbol{nodo: :RET, inodo: enodo}, cola}
	  else
	    {{:bad, "falta el punto y coma"}, cola}
	  end
      end
      end
    end
  end

end
