#############################################################################
##
#M  Typeset( <object> ) . 
##  
## produces a typesettable string representing the provided object.
##
InstallMethod(Typeset, "for all objects", true,
[ IsObject ],0,
function( x, opts... )
	local options, defaults, name, t, f, string;

	if IsEmpty(opts) then
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
	elif Length(opts)>=1 then
		options := opts[1];
		if Length(opts) > 1 then
			# Throw error
			Error("More than one optional argument passed.");
		fi;
	fi;

	# Determine function to create output string (based on lang option).
	f := options.("Lang");
	f[1] := UppercaseChar(f[1]);
	t := EvalString(Concatenation(f, "String"));
	string := t(x : options := options);
	Add(string, '\n');
	Print(string);
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
InstallMethod(GenLatexTmpl, "fallback default method for all objects", true,
[ IsObject ], 0,
function( obj )
	return "{}";
end);

InstallMethod(GenLatexTmpl, "for rationals", true,
[ IsRat ], 0,
function( x )
	if IsInt(x) then
		return "{}";
	fi;
	return "\\frac{{{}}}{{{}}}";
end);

InstallMethod(GenLatexTmpl, "for an internal FFE", true,
[IsFFE and IsInternalRep], 0,
function ( ffe )
	local str, log,deg,char;
  	char := Characteristic(ffe);
  	if IsZero( ffe ) then
    	str := "0*Z({})";
  	else
    	str := "Z({}{}){}";
  	fi;
  	ConvertToStringRep(str);
  	return str;
end );

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
      	Append(s,"{} ");
      	if j<n then
        	Append(s,"& ");
      	fi;
    	od;
    	Append(s,"\\\\\n");
  	od;
  	Append(s,"\\end{{array}}\\right)");
  	return s;
end);

InstallMethod(GenLatexTmpl, "for polynomials", true,
[ IsPolynomial ], 0,
function ( poly )
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
				Append(str, "{}");
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

	return str;
end);

InstallMethod(GenLatexTmpl, "for character tables", true,
[ IsCharacterTable ], 0,
function (tbl )
	local ret, cnr, classes, i, j, k, nCols, nRows, header;

	ret := "\\begin{{tabular}}{{";
	cnr := CharacterNames(tbl);
	classes := ClassNames(tbl);

	nRows := Length(cnr);
	nCols := Length(classes);

	# Format specifier.
	for i in [1..nCols] do
		Append(ret, "c ");
	od;
	Append(ret, "c}}\n & ");

	header := JoinStringsWithSeparator(ClassNames(tbl), " & ");
	Append(ret, header);
	Append(ret, " \\\\\n");

	for j in [1..nRows] do
		Append(ret, cnr[j]);
		Append(ret, " & ");
		for k in [2..nCols] do
			Append(ret, "{} & ");
		od;
		Append(ret, "{} \\\\\n");
	od;

	# Closing environment, with empty space for legend.
	Append(ret, "\\end{{tabular}}{}");

	return ret;
end);

InstallMethod(GenLatexTmpl, "for fp groups", true,
[ IsFpGroup ], 0,
function ( g )
	local str;
	str := "\\langle";

	for i in [1..Length(GeneratorsOfGroup(g))] do
		str := Concatenation(str, "{},");
	od;
	str := Concatenation(str{[1..Length(str)-1]}, "\\mid");

	for i in [1..Length(RelatorsOfFpGroup(g))] do
		str := Concatenation(str, "{},");
	od;
	str := Concatenation(str{[1..Length(str)-1]}, "\\rangle");

	return str;
end);

InstallMethod(GenLatexTmpl, "for pc groups", true,
[ IsPcGroup ], 0,
function ( g )
	local str;
	str := "\\langle";

	return str;
end);

InstallMethod(GenLatexTmpl, "for matrix groups", true,
[ IsMatrixGroup ], 0,
function ( g )
	local str, i;
	str := "\\langle";

	for i in [1..Length(GeneratorsOfGroup(g))] do
		str := Concatenation(str, "{},");
	od;
	str := Concatenation(str{[1..Length(str)-1]}, "\\rangle");

	return str;
end);

InstallMethod(GenLatexTmpl, "for permutation groups", true,
[ IsPermGroup ], 0,
function ( g )
	local str, i;
	str := "\\langle";

	for i in [1..Length(GeneratorsOfGroup(g))] do
		str := Concatenation(str, "{},");
	od;
	str := Concatenation(str{[1..Length(str)-1]}, "\\rangle");

	return str;
end);

InstallMethod(GenLatexTmpl,"assoc word in letter rep",true,
[IsAssocWord and IsLetterAssocWordRep],0,
function( elm )
	local names,len,i,g,h,e,a,s;

	names:= ShallowCopy(FamilyObj( elm )!.names);
	for i in [1..Length(names)] do
		s:=names[i];
		e:=Length(s);
		while e>0 and s[e] in CHARS_DIGITS do
			e:=e-1;
		od;
		if e<Length(s) then
			if e=Length(s)-1 then
				s:=Concatenation(s{[1..e]},"_",s{[e+1..Length(s)]});
			else
				s:=Concatenation(s{[1..e]},"_{",s{[e+1..Length(s)]},"}");
			fi;
			names[i]:=s;
		fi;
	od;

	s:="";
	elm:=LetterRepAssocWord(elm);
	len:= Length( elm );
	i:= 2;
	if len = 0 then
		return( "id" );
	else
		g:=AbsInt(elm[1]);
		e:=SignInt(elm[1]);
		while i <= len do
			h:=AbsInt(elm[i]);
			if h=g then
				e:=e+SignInt(elm[i]);
			else
				Append(s, names[g] );
				if e<>1 then
					Append(s,"^{");
					Append(s,String(e));
					Append(s,"}");
				fi;
				g:=h;
				e:=SignInt(elm[i]);
			fi;
			i:=i+1;
		od;
		Append(s, names[g] );
		if e<>1 then
			Append(s,"^{");
			Append(s,String(e));
			Append(s,"}");
		fi;
	fi;
	return s;
end);

#############################################################################
##
#M  GenArgs( <object> ) . 
##  
## produces a list of objects representing the semantics of the provided object.
## used to populate the template string.
##
InstallMethod(GenArgs, "fallback default method", true,
[ IsObject ], 0, String);

InstallMethod(GenArgs, "rational", true,
[ IsRat ], 0,
function (x)
	if IsInt(x) then
    	return [ String(x) ];
  	fi;
	return [ NumeratorRat(x), DenominatorRat(x) ];
end);

InstallMethod(GenArgs, "internal ffe", true,
[ IsFFE and IsInternalRep ], 0,
function ( ffe )
	local char, ret, deg, log;
	char := Characteristic(ffe);
	ret := [ char, "", "" ];
	if not IsZero(ffe) then
		deg := DegreeFFE(ffe);
		if deg <> 1  then
			ret[2] := Concatenation("^{", String(deg), "}");
		fi;

		log := LogFFE(ffe,Z( char ^ deg ));
		if log <> 1 then
			ret[3] := Concatenation("^{", String(log), "}");
		fi;
	fi;

	return ret;
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
			Add(r, LatexString(m[i][j] : options := subOptions));
		od;
	od;

	return r;
end);

InstallMethod(GenArgs, "polynomials", true,
[ IsPolynomial ], 0, 
function(poly)
	local i, j, fam, ext, zero, one, mone, c, le, r, subOptions;
	subOptions := MergeSubOptions(ValueOption("options"));

	r := [];
	fam := FamilyObj(poly);
	ext := ExtRepPolynomialRatFun(poly);
	zero := fam!.zeroCoefficient;
	one := fam!.oneCoefficient;
	mone := -one;
	le := Length(ext);

	for i in [ le-1, le-3..1 ] do
		c := false;
		if ext[i + 1] <> one and ext[i + 1] <> mone then
			Add(r, LatexString(ext[i + 1] : options := subOptions));
			c := true;
		fi;

		if Length(ext[i]) > 1 then
			for j in [ 1, 3 .. Length(ext[i]) - 1] do
				if 1 <> ext[i][j + 1] then
					Add(r, LatexString(ext[i][j + 1] : options := subOptions));
				fi;
			od;
		else
			if c=false then
				Add(r, LatexString(ext[i + 1] : options := subOptions));
			fi;
		fi;
	od;

	return r;
end);

InstallMethod(GenArgs, "character tables", true,
[ IsCharacterTable ], 0,
function( tbl )
	local ret, chars, data, i, j, entry;
	ret := [];
	chars := List(Irr(tbl), ValuesOfClassFunction);
	data := CharacterTableDisplayStringEntryDataDefault(tbl);

	# Generate character substitutions.
	for i in [1..Length(chars)] do
		for j in [1..Length(chars[i])] do
			entry := CharacterTableDisplayStringEntryDefault(chars[i][j], data);
			if '/' in entry then
				# Use bar environment for complex conjugate.
				entry := Concatenation(ReplacedString(entry, "/", "\\bar{"), "}");
			fi;
			Add(ret, entry);
		od;
	od;

	# Generate Legend.
	# Print("\% For including legends, make sure to include the amsmath package in your preamble (\\usepackage{amsmath})\n");
	Add(ret, CtblLatexLegend(data));

	return ret;
end);

InstallMethod(GenArgs, "permutation", true,
[ IsPerm ], 0,
function (x)
	local list;
	list := [ String(x) ];
	return list;
end);

InstallMethod(GenArgs, "fp groups", true, [ IsFpGroup ], 0,
function ( g )
	local lst, gens, rels;
	lst := [];
	gens := GeneratorsOfGroup(g);
	rels := RelatorsOfFpGroup(g);

	for i in [1..Length(gens)] do
		Add(lst, LatexString(gens[i]));
	od;

	for i in [1..rels] do
		Add(lst, LatexString(rels[i]))
	od;

	return lst;
end);

InstallMethod(GenArgs, "pc groups", true, [ IsPcGroup ], 0,
function ( g )
	local lst;

	lst := [];

	return lst;
end);

InstallMethod(GenArgs, "matrix groups", true, [ IsMatrixGroup ], 0,
function ( g )
	local lst, gens, i;
	lst := [];
	gens := GeneratorsOfGroup(g);

	for i in [1..Length(gens)] do
		Add(lst, LatexString(gens[i]));
	od;

	return lst;
end);

InstallMethod(GenArgs, "permutation groups", true, [ IsPermGroup ], 0,
function ( g )
	local lst, gens, i;
	lst := [];
	gens := GeneratorsOfGroup(g);

	for i in [1..Length(gens)] do
		Add(lst, String(gens[i]));
	od;

	return lst;
end);

InstallMethod(GenArgs,"assoc word in letter rep",true,
[IsAssocWord and IsLetterAssocWordRep],0,
function( elm )
	return [];
end);

#############################################################################
##
#M  CtblLatexLegend( <character table entry data> ) . 
##  
## generates a legend that specifies what substitutions have been used in a
## representation of the character table. Uses the align environment.
##
InstallMethod(CtblLatexLegend, "for generating LaTeX representation of a character table legend", true,
[ IsRecord ], 0,
function (data) 
	local ret, irrstack, irrnames, i, q;
	ret := "";

	irrstack := data.irrstack;
	if not IsEmpty(irrstack) then
		irrnames := data.irrnames;
		Append(ret, "\n\\begin{align*}\n");
	fi;

	for i in [1..Length(irrstack)] do
		Append(ret, irrnames[i]);
		Append(ret, " &= ");
		Append(ret, String(irrstack[i]));
		Append(ret, " \\\\\n");

		q:= Quadratic(irrstack[i]);
		if q <> fail then
			Append(ret, " &= ");
			Append(ret, q.display);
			Append(ret, " = ");
			Append(ret, q.ATLAS);
			Append(ret, " \\\\\n");
		fi;
	od;

	if ret <> "" then
		Append(ret, "\\end{align*}");
	fi;

	return ret;
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