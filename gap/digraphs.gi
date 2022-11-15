#############################################################################
##
#M  GenLatexTmpl( <object> ) . 
##  
## produces a template LaTeX string representing the structure of the provided object.
##
InstallMethod(GenLatexTmpl, "for directed graphs", true,
[ IsDigraph ], 0,
function( obj )
	return "{}";
end);

#############################################################################
##
#M  GenArgs( <object> ) . 
##  
## produces a list of objects representing the semantics of the provided object.
## used to populate the template string.
##
InstallMethod(GenArgs, "directed graphs", true,
[ IsDigraph ], 0, String);