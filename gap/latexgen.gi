#! @Section Method Definitions
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

InstallMethod(GenLatexTmpl, "for rationals", true,
[ IsRat ], 0,
function( x )
	return "{}";
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
					Append(str, "- {}");
				else
					Append(str, "+ {}");
				fi;
			fi;	
		fi;

		if Length(ext[i]) < 2 then
			if c=true then
				Append(str, String(one));
			fi;
		else
			for j in [ 1, 3 .. Length(ext[i]) - 1] do
				Append(str, "{}");
			od;
		fi;
	od;

	return str;
end);

InstallMethod(GenArgs, "rational", true,
[ IsRat ], 0,
function (x)
	local list;
	list := [ String(x) ];
	return list;
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