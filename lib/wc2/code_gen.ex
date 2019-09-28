defmodule Wc2.CodeGen do

  def gen_code(tree) do
    code = travel_tree(tree)
    #IO.puts("\nCode Generator output:")
    #IO.puts(code)
    code
  end

  def travel_tree(node) do
    case  node do
      :nil -> :nil
      tree_node ->
	code_snippet = travel_tree(tree_node.lleaf)
	travel_tree(tree_node.rleaf)
	emit_code(tree_node.node,
	  code_snippet,
	  tree_node.val)
    end
  end

  def emit_code(:program, code_snippet, _) do
    """
    .text
    .p2align        4
    """ <>
      code_snippet
  end

  def emit_code(:function, code_snippet, :main) do
    """
    .globl  main         
    .type    main, @function
    main:
    """ <>
      code_snippet
  end

  def emit_code(:kreturn, code_snippet, _) do
    """
    movl    #{code_snippet}, %eax
    ret
    """
  end

  def emit_code(:const, _code_snippet, value) do
    "$#{value}"
  end
  
end
