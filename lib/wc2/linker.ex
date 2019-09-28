defmodule Wc2.Linker do
  def get_bin(assembler, assembly_path, pers) do
    assembly_file_name = Path.basename(assembly_path)
    binary_file_name = Path.basename(assembly_path, ".s")
    output_dir_name = Path.dirname(assembly_path)
    assembly_path = output_dir_name <> "/" <> assembly_file_name

    File.write!(assembly_path, assembler)

    if pers do
      System.cmd("gcc", [assembly_file_name, "-o#{binary_file_name}.out"],
      cd: output_dir_name)
    else
      System.cmd("gcc", [assembly_file_name, "-o#{binary_file_name}"],
      cd: output_dir_name)
    end
    
    System.cmd("gcc", [assembly_file_name, "-o#{binary_file_name}"],
      cd: output_dir_name)
    File.rm!(assembly_path)
    0
  end
end
