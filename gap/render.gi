#############################################################################
##
#M  RenderLatex( <string> ) . 
##  
## renders a given string in a LaTeX environment.
##
InstallMethod(RenderLatex, "for all LaTeX strings", true,
[ IsString ], 0,
function( x )
    return "";
end);