#############################################################################
##
#M  GenMathmlTmpl( <object> ) . 
##  
## produces a template MathML string representing the structure of the provided object.
##
InstallMethod(GenMathmlTmpl, "fallback default method for all objects", true,
[ IsObject ], 0,
function( obj )
	return "{}";
end);

InstallMethod(GenMathmlTmpl, "for rationals", true,
[ IsRat ], 0,
function( x )
	if IsInt(x) then
		return "{}";
	else
		return "\\frac{{{}}}{{{}}}";
	fi;
end);