defmodule Compiladorwombat do
  @moduledoc """
  El compilador del equipo Wombat
  """

  @commands %{
    'help' => 'Ayuda',
    's' => 'Imprime codigo en asm',
    'o' => 'Salida'
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
  
  defp print_help_message do
    IO.puts("\nnqcc --help file_name \n")

    IO.puts("\nThe compiler supports following options:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end

  def compile_file(path) do
    IO.puts("Compilado: " <> path)
    asm_path = String.replace_leading(path, '.c', '.s')
    
    File.read!(path)
    |> Wc2.Lexer.scanner_words
    |> IO.inspect(label: "\n Salida Lexer: ")
    |> Wc2.Analizador.parse_program
    |> IO.inspect(label: "\nSalida parser: ")
    |> Wc2.CodeGen.gen_code
    |> Wc2.Linker.ge_link(asm_path)
  end

  
end
