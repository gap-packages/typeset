#############################################################################
##
#M  GenMathmlTmpl( <object> ) . 
##  
## produces a template MathML string representing the structure of the provided object.
##
InstallMethod(GenMathmlTmpl, "fallback default method for all objects", true,
[ IsObject ], 0,
function( obj )
	Info(InfoTypeset, 2, "Could not find installed MathML template method for object filter, falling back to default method.");
	return "{}";
end);

InstallMethod(GenMathmlTmpl, "for rationals", true,
[ IsRat ], 0,
function( x )
	if IsInt(x) then
		return "<mn>{}</mn>";
	else
		return "<mfrac><mn>{}</mn><mn>{}</mn></mfrac>";
	fi;
end);

InstallMethod(GenMathmlTmpl, "for infinity", true,
[ IsInfinity ], 0,
function ( inf )
	return "<infinity/>";
end);

InstallMethod(GenMathmlTmpl, "for negative infinity", true,
[ IsNegInfinity ], 0,
function ( inf )
	return "-<infinity/>";
end);

InstallMethod(GenMathmlTmpl, "for lists", true,
[ IsList ], 0,
function ( lst )
	local i, j, l, s, opts, left, right;
	opts := ValueOption("options");

	# Get delimiters.
	left := opts.("LDelim");
	right := opts.("RDelim");

	l := Length(lst);
	s := Concatenation("<mo>", left);
	Append(s, "</mo>");

	for i in [1..l] do
		Append(s, "{}");
		if i < l then
			Append(s, "<mo>,&nbsp;</mo>");
		fi;
	od;

	Append(s, "<mo>");
	Append(s, right);
	Append(s, "</mo>");
	return s;
end);

InstallMethod(GenMathmlTmpl, "for matrices", true,
[ IsMatrix ], 0,
function( m )
	local i, j, l, n, s, opts, left, right;
	opts := ValueOption("options");

	if opts.("MatAsList") then
		TryNextMethod();
	fi;

	# Get delimiters.
	left := opts.("LDelim");
	right := opts.("RDelim");

	l := Length(m);
  	n := Length(m[1]);
  	s := Concatenation("<mo>", left);
	Append(s, "</mo><mtable>");

  	for i in [1..l] do
		Append(s,"<mtr>");
    	for j in [1..n] do
      		Append(s,"<mtd>{}</mtd>");
    	od;
    	Append(s,"</mtr>");
  	od;
  	Append(s,"</mtable><mo>");
	Append(s, right);
	Append(s, "</mo>");
  	return s;
end);
