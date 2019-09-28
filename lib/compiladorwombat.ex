defmodule Compiladorwombat do
  @moduledoc """
  El compilador del equipo Wombat
  """


  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args,
      switches: [
	help: :boolean,
	assembler: :string,
	output: :string],
      aliases: [
	h: :help,
	s: :assembler,
	o: :output])

  end

  def process_args(opts) do
    case opts do
      {[output: filepathOut], [filepath], _} ->
	System.halt(compile_file(filepath, filepathOut))

      {_, [filepath], _} ->
	System.halt(compile_file(filepath))
      
      {[output: _], _, _} ->
	IO.puts("\e[0;31mError\e[0m: No se especifica el archivo")
	System.halt(1)
	
      {[help: true], _, _} ->
	IO.puts(print_manual())
	System.halt(0)
	
	_ ->
	IO.puts(print_help_message())
	System.halt(1)
    end
  end

  # def process_args({_, _, _})do
  #   IO.puts("\n compiladorwombat --help para imprimir la ayuda")
  # end

  defp print_manual() do
    """

    $ compiladorwombat [COMANDOS] [PATH/FILE]

    Ingrese el comando o la ruta del archivo.c
    
    Comandos:
    \t--help, -h\tImprime el manual
    \t--assembler, -s\tAsigna la salida del archivo ensamblador
    \t--output, -o\tAsigna la salida del binario

    """
  end
  
  defp print_help_message() do
      """
      \e[0;31mError fatal\e[0;0m: No hay archivos de entrada
      --help,\t-h\tImprime la ayuda
      """
  end

  def compile_file(path) do
    IO.puts("\e[0;32mCompilado\e[0;0m: " <> path)
    asm_path = String.replace_trailing(path, ".c", ".s")


    sts = File.read!(path)
    with {:ok, something} <- Wc2.Lexer.sanitizer(sts),
	 {:ok, something} <- Wc2.Lexer.scanner_words(something),
	 {:ok, something} <- Wc2.Analizador.parse_program(something) do
      something |> Wc2.CodeGen.gen_code |> Wc2.Linker.get_bin(asm_path, :false)
      0
    else
      {:error, something} ->
	IO.inspect something
	1
      _ -> 1 
    end
  end

   def compile_file(path, dest_path) do
    IO.puts("\e[0;32mCompilado\e[0;0m - ruta personalizada: " <> path)
    asm_path = String.replace_trailing(path, ".c", ".s")
    
    sts = File.read!(path)
    with {:ok, something} <- Wc2.Lexer.sanitizer(sts),
	 {:ok, something} <- Wc2.Lexer.scanner_words(something),
	 {:ok, something} <- Wc2.Analizador.parse_program(something) do
      something |> Wc2.CodeGen.gen_code |> Wc2.Linker.get_bin(asm_path, dest_path)
      
      0
    else
      {:error, something} ->
	IO.inspect something
	1
      _ -> 1 
    end
  end

  def probes(path) do
    case compile_file(path) do
      :error ->
	:error
      _ -> :ok
    end
  end

  
end
