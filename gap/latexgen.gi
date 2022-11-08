#############################################################################
##
#M  Typeset( <object> ) . 
##  
## produces a typesettable string representing the provided object.
##
InstallMethod(Typeset, "for all objects", true,
[ IsObject ],0,
function( x )
	local options, defaults, name, t, f;

	if ValueOption("options") = fail then
		# Merge default options with user-passed optional parameters.
		defaults := rec(MatrixDelim := "[]", Lang := "latex", SubCallOpts := false);
		options := rec();

		for name in RecNames(defaults) do
			if ValueOption(name) = fail then
				options.(name) := defaults.(name);
			else
				options.(name) := ValueOption(name);
			fi;
		od;
	else
		# Handling where options struct has already been constructed.
		options := ValueOption("options");
	fi;

	# Determine function to create output string (based on lang option).
	f := options.("Lang");
	f[1] := UppercaseChar(f[1]);
	t := EvalString(Concatenation(f, "String"));
	Print(t(x : options := options));
end);

#############################################################################
##
#M  LatexString( <object> ) . 
##  
## produces a LaTeX-renderable string representing the provided object.
##
InstallMethod(LatexString, "for all objects", true,
[ IsObject ],0,
function( x )
	local options, string, args, tmpl;
	
	options := ValueOption("options");
	args := GenArgs(x : options := options);
	tmpl := GenLatexTmpl(x : options := options);
	Add(args, tmpl, 1);
	string := CallFuncList(StringFormatted, args);
	return string;
end);

#############################################################################
##
#M  GenLatexTmpl( <object> ) . 
##  
## produces a template LaTeX string representing the structure of the provided object.
##
InstallMethod(GenLatexTmpl, "for rationals", true,
[ IsRat ], 0,
function( x )
	if IsInt(x) then
		return "{}";
	fi;
	return "\\frac{{{}}}{{{}}}";
end);

InstallMethod(GenLatexTmpl, "matrix", true,
[ IsMatrix ], 0,
function( m )
	local i,j,l,n,s;

  	l:=Length(m);
  	n:=Length(m[1]);
  	s:="\\left(\\begin{{array}}{{";
  	for i in [1..n] do
    	Add(s,'r');
  	od;
  	Append(s,"}}\n");
  	for i in [1..l] do
    	for j in [1..n] do
      	Append(s,"{}");
      	if j<n then
        	Add(s,'&');
      	fi;
    	od;
    	Append(s,"\\\\\n");
  	od;
  	Append(s,"\\end{{array}}\\right)\n");
  	return s;
end);

InstallMethod(GenLatexTmpl, "for polynomials", true,
[ IsPolynomial ], 0,
function (poly)
	local fam, ext, str, zero, one, mone, le, c, s, ind, i, j;

	fam := FamilyObj(poly);
	ext := ExtRepPolynomialRatFun(poly);
	zero := fam!.zeroCoefficient;
	one := fam!.oneCoefficient;
	mone := -one;
	le := Length(ext);
	str := "";

	if le=0 then
		return String(zero);
	fi;

	for i in [ le-1, le-3..1 ] do
		c := true;
		if ext[i + 1]=one then
			if i<le-1 then
				Append(str, "+");
			fi;
			c := false;
		elif ext[i + 1]=mone then
			Append(str, "-");
			c := false;
		else
			if IsRat(ext[i + 1]) then
				if ext[i + 1]<0 then
					Append(str, "{}");
				else
					if i<le-1 then
						Append(str, "+");
					fi;
					Append(str, "{}");
				fi;
			fi;	
		fi;

		if Length(ext[i]) < 2 then
			if c=false then
				Append(str, String(one));
			fi;
		else
			for j in [ 1, 3 .. Length(ext[i]) - 1] do
				ind:=ext[i][j];
				if HasIndeterminateName(fam,ind) then
					Append(str,IndeterminateName(fam,ind));
				else
					Append(str,"x_{{");
					Append(str,String(ind)); 
					Append(str,"}}");
				fi;
				if 1 <> ext[i][j+1]  then
					Append(str,"^{{");
					Append(str,"{}");
					Append(str,"}}");
				fi;
			od;
		fi;
	od;
	Append(str, "\n");

	return str;
end);

#############################################################################
##
#M  GenArgs( <object> ) . 
##  
## produces a list of objects representing the semantics of the provided object.
## used to populate the template string.
##
InstallMethod(GenArgs, "rational", true,
[ IsRat ], 0,
function (x)
	if IsInt(x) then
    	return [ String(x) ];
  	fi;
	return [ NumeratorRat(x), Denominator(x) ];
end);

InstallMethod(GenArgs, "matrix", true,
[ IsMatrix ], 0,
function ( m )
	local i, j, l, n, r, subOptions;
	subOptions := MergeSubOptions(ValueOption("options"));

	l:=Length(m);
  	n:=Length(m[1]);
	r := [];

	for i in [1..l] do
		for j in [1..n] do
			Append(r, LatexString(m[i][j] : options := subOptions));
		od;
	od;

	return r;
end);

InstallMethod(GenArgs, "polynomials", true,
[ IsPolynomial ], 0, 
function(poly)
	local i, j, fam, ext, zero, one, mone, le, r, subOptions;
	subOptions := MergeSubOptions(ValueOption("options"));

	r := [];
	fam := FamilyObj(poly);
	ext := ExtRepPolynomialRatFun(poly);
	zero := fam!.zeroCoefficient;
	one := fam!.oneCoefficient;
	mone := -one;
	le := Length(ext);

	for i in [ le-1, le-3..1 ] do
		if ext[i + 1] <> one and ext[i + 1] <> mone then
			Add(r, ext[i + 1]);
		fi;

		if Length(ext[i]) > 1 then
			for j in [ 1, 3 .. Length(ext[i]) - 1] do
				if 1 <> ext[i][j + 1] then
					Add(r, ext[i][j + 1]);
				fi;
			od;
		fi;
	od;

	return r;
end);

#############################################################################
##
#M  MergeSubOptions( <options record> ) . 
##  
## generates a new options record that can be passed to sub-calls from a parent.
## used to allow users to set options that may differ between recursive calls
## of a single method (e.g. Matrix delimitors).
##
InstallMethod(MergeSubOptions, "for generating alternative sub-call options", true,
[ IsRecord ], 0,
function ( opts )
	local subOptions, tempSub, name;

	subOptions := opts;
	if IsRecord(opts.("SubCallOpts")) then
		tempSub := opts.("SubCallOpts");
		Unbind(opts.("SubCallOpts"));
		for name in RecNames(tempSub) do
			subOptions.(name) := tempSub.(name);
		od;
	fi;

	return subOptions;
end);