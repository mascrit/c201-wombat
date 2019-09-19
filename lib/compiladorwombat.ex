defmodule Compiladorwombat do
  @moduledoc """
  El compilador del equipo Wombat
  """

  @commands %{
    'h' => 'Ayuda',
#    's' => 'Imprime codigo en asm',
#    'o' => 'Salida'
  }

  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean, o: :boolean])

  end

  def process_args({[help: true], _, _}) do
    print_help_message()
  end

  def process_args({_, [file_name], _})do
    compile_file(file_name)
  end

  # def process_args({_, _, _})do
  #   IO.puts("\n compiladorwombat --help para imprimir la ayuda")
  # end

  
  defp print_help_message do
    IO.puts("\compiladorwombat ruta/nombre_del_archivo.c \n")

    IO.puts("\nEl compilador soporta las siguientes opciones:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end

  def compile_file(path) do
    IO.puts("Compilado: " <> path)
    asm_path = String.replace_trailing(path, ".c", ".s")
    
    sts =File.read!(path)
    |> Wc2.Lexer.sanitizer
    |> IO.inspect(label: "\n Salida del desinfectante: ")
    |> Wc2.Lexer.scanner_words
    |> IO.inspect(label: "\n Salida Lexer: ")
    case sts do
      {:error, text} ->
	IO.inspect({:error, text})
	1
      _ ->
	sts = sts
	|> Wc2.Analizador.parse_program
	|> IO.inspect(label: "\nSalida parser: ")

	case sts do
	  {:error, text} ->
	    IO.inspect{:error, text}
	    1
	  _ ->
	    sts
	    |> Wc2.CodeGen.gen_code()
	    |> Wc2.Linker.get_bin(asm_path)
	    0
	end
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
