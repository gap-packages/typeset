#############################################################################
##
#M  GenLatexTmpl( <digraph> ) . 
##  
## produces a template LaTeX string representing the structure of the provided digraph.
##
InstallMethod(GenLatexTmpl, "for directed graphs", true,
[ IsDigraph ], 0,
function( obj )
	return "\\begin{{center}}\n\\begin{{tikzpicture}}[>=latex',line join=bevel,]\n{}\n\\end{{tikzpicture}}\n\\end{{center}}";
end);

#############################################################################
##
#M  GenArgs( <digraph> ) . 
##  
## produces a list of strings representing the semantics of the provided digraph.
## used to populate the template string.
##
InstallMethod(GenArgs, "directed graphs", true,
[ IsDigraph ], 0,
function ( obj )
	local dot, ret;
	
	# Simply makes use of the dot2texi LaTeX package to allow raw DOT to be input
	# and converted during LaTeX compilation.
	Info(InfoLatexgen, 2, "To use the dot2tex environment, add the dot2texi package to your premable \\usepackage{dot2texi}");
	dot := DotDigraph(obj);
	ret := "\\begin{dot2tex}[dot,tikz,codeonly,styleonly,options=-s -tmath]\n";
	Append(ret, dot);
	Append(ret, "\n\\end{dot2tex}");
	return [ ret ];
end);

#############################################################################
##
#M  Dot2Tex( <digraph> ) . 
##  
## produces a list of strings representing the semantics of the provided digraph.
## used to populate the template string.
##
InstallMethod(Dot2Tex, "directed graphs", true,
[ IsDigraph ], 0,
function ( obj )
	local dot, dir, f, ret, inp, out, tmp, midI, midO;
	dot := DotDigraph(obj);
	inp := InputTextString(dot);

	# Construct temporary vars to pass as arguments to Process.
	dir := DirectoryTemporary();
    f := Filename(DirectoriesSystemPrograms(), "dot2tex");

	# Pre-process dot using graphviz.
	tmp := "";
	midI := OutputTextString(tmp, true);
	Process(dir, f, inp, midI, ["--preproc"]);
	midO := InputTextString(tmp);

	# Call dot2tex on preprocessed dot string.
	ret := "\\begin{center}\n\\begin{tikzpicture}[>=latex',line join=bevel,]\n";
	out := OutputTextString(ret, true);
	Process(dir, f, midO, out, ["--figonly", "--codeonly"]);
	Append(ret, "\\end{tikzpicture}\n\\end{center}");
	Print(ret);
end);