#############################################################################
##
#M  GenLatexTmpl( <digraph> ) . 
##  
## produces a template LaTeX string representing the structure of the provided digraph.
##
InstallMethod(GenLatexTmpl, "for directed graphs", true,
[ IsDigraph ], 0,
function( obj )
	return "\\begin{center}\n\\begin{tikzpicture}[>=latex',line join=bevel,]\n{}\n\\end{tikzpicture}\n\\end{center}";
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
	dot := DotDigraph(obj);

	# Simply makes use of the dot2texi LaTeX package to allow raw DOT to be input
	# and converted during LaTeX compilation.
	ret := "\\begin{dot2tex}[dot,tikz,codeonly,styleonly,options=-s -tmath]\n";
	Append(ret, dot);
	Append(ret, "\n\\end{dot2tex}");

	return ret;
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
	local dot, dir, f, ret;
	dot := DotDigraph(obj);

	# Construct temporary file to pass as command line argument.
	dir := DirectoryTemporary();
    f := Filename(dir, "dot2tex.dot");
	PrintTo(f, dot);

	# Call dot2tex on prepared dot file.
	Exec(Concatenation("cd ", Filename(dir, ""), ";", "dot2tex --preproc dot2tex.dot | dot2tex --figonly --codeonly"));

	# Read output tex file.
	f := Filename(dir, "dot2tex.tex");
	ret := Read(f);

	return ret;
end);