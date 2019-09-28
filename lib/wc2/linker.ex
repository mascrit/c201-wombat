defmodule Wc2.Linker do
  def get_bin(assembler, assembly_path, route) do

    if route do 
	abs_route = Path.absname(Path.dirname(route)<>"/"<>route)
	asm_file = Path.basename(assembly_path)
	dir_asm = Path.dirname(assembly_path)
	
	asm_path = dir_asm<>"/"<>asm_file
	File.write!(asm_path, assembler)
	System.cmd("gcc", [asm_file, "-o"<>abs_route],
	  cd: dir_asm)
    else
    	assembly_file_name = Path.basename(assembly_path)
	binary_file_name = Path.basename(assembly_path, ".s")
	output_dir_name = Path.dirname(assembly_path)
	assembly_path = output_dir_name <> "/" <> assembly_file_name
	
	File.write!(assembly_path, assembler)
	System.cmd("gcc", [assembly_file_name, "-o#{binary_file_name}"],
	  cd: output_dir_name)
	File.rm!(assembly_path)	
    end
  end
end
