#############################################################################
##
#M  GenLatexTmpl( <object> ) . 
##  
## produces a template LaTeX string representing the structure of the provided object.
##
InstallMethod(GenLatexTmpl, "fallback default method for all objects", true,
[ IsObject ], 0,
function( obj )
	Info(InfoTypeset, 2, "Could not find installed LaTeX template method for object filter, falling back to default method");
	return "{}";
end);

InstallMethod(GenLatexTmpl, "for rationals", true,
[ IsRat ], 0,
function( x )
	if IsInt(x) then
		return "{}";
	else
		return "\\frac{{{}}}{{{}}}";
	fi;
end);

InstallMethod(GenLatexTmpl, "for infinity", true,
[ IsInfinity ], 0,
function ( inf )
	return "\\infty";
end);

InstallMethod(GenLatexTmpl, "for negative infinity", true,
[ IsNegInfinity ], 0,
function ( ninf )
	return "-\\infty";
end);

InstallMethod(GenLatexTmpl, "for an internal FFE", true,
[ IsFFE and IsInternalRep ], 0,
function ( ffe )
	local str, log, deg, char;
  	char := Characteristic(ffe);
  	if IsZero(ffe) then
    	str := "0 \\times Z({})";
  	else
    	str := "Z({}{}){}";
  	fi;
  	ConvertToStringRep(str);
  	return str;
end );

InstallMethod(GenLatexTmpl, "for permutations", true,
[ IsPerm ], 0,
function( perm )
	local str, i, j, maxpnt, blist;
  	if IsOne(perm) then
      	str := "\\left(\\right)";
  	else
      	str := "";
      	maxpnt := LargestMovedPoint(perm);
      	blist := BlistList([1..maxpnt], []);
      	for i in [1 .. LargestMovedPoint(perm)] do
      		if not blist[i] and i ^ perm <> i  then
          		blist[i] := true;
          		Append(str, "\\left({}");
          		j := i ^ perm;
          		while j > i do
          			blist[j] := true;
          			Append(str, ",{}");
          			j := j ^ perm;
          		od;
          		Append(str, "\\right)");
      		fi;
      	od;
  	fi;

  	return str;
end );

InstallMethod(GenLatexTmpl, "for lists", true,
[ IsList ], 0,
function( lst )
	local str, i;
  	str := "[";
  	for i in [1..Length(lst)] do
		Append(str, "{}");
		if i<Length(lst) then
	  		Append(str, ",");
		fi;
  	od;
  	Append(str, "]");

  	return str;
end );

InstallMethod(GenLatexTmpl, "for matrices", true,
[ IsMatrix ], 0,
function( m )
	local i, j, l, n, s, opts, left, right;
	opts := ValueOption("options");

	if opts.("MatAsList") then
		TryNextMethod();
	fi;

	# Get delimiters (and replace angled brackets).
	left := ReplacedString(ReplacedString(opts.("LDelim"), "<", "\\langle"), ">", "\\rangle");
	right := ReplacedString(ReplacedString(opts.("RDelim"), "<", "\\langle"), ">", "\\rangle");

  	l := Length(m);
  	n := Length(m[1]);
  	s := Concatenation("\\left", left);
	Append(s, "\\begin{{array}}{{");

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
  	Append(s,"\\end{{array}}\\right");
	Append(s, right);
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

InstallMethod(GenLatexTmpl, "for rational functions (non-polynomial)", true,
[ IsRationalFunction ], 0,
function( ratf )
	return "\\frac{{{}}}{{{}}}";
end);

InstallMethod(GenLatexTmpl, "for character tables", true,
[ IsCharacterTable ], 0,
function (tbl )
	local ret, cnr, classes, i, j, k, nCols, nRows, header;

	Info(InfoTypeset, 2, "To use the gather* LaTeX environment in character tables, add the amsmath package to your premable \\usepackage{amsmath}");
	ret := "\\begin{{gather*}}\n\\begin{{array}}{{";
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
	Append(ret, "\\end{{array}}{}\n\\end{{gather*}}");

	return ret;
end);

InstallMethod(GenLatexTmpl, "for fp groups", true,
[ IsFpGroup ], 0,
function ( g )
	local str, gens, i, s, e, j;
	str := "\\left\\langle ";

	gens := GeneratorsOfGroup(g);
	for i in [1..Length(gens)] do
		s := String(gens[i]);
		e := Length(s);

		while e>0 and s[e] in CHARS_DIGITS do
			e := e-1;
		od;

		if e<Length(s) then
			str := Concatenation(str,"{}_{{{}}},");
		else
			str := Concatenation(str, "{},");
		fi;
	od;
	str := Concatenation(str{[1..Length(str)-1]}, " \\mid ");

	for j in [1..Length(RelatorsOfFpGroup(g))] do
		str := Concatenation(str, "{},");
	od;
	str := Concatenation(str{[1..Length(str)-1]}, " \\right\\rangle");

	return str;
end);

InstallMethod(GenLatexTmpl, "for pc groups", true,
[ IsPcGroup ], 0,
function ( g )
	local str, iso, fp;
	iso := IsomorphismFpGroupByPcgs(FamilyPcgs (g), "f");
	fp := Image(iso);

	return GenLatexTmpl(fp);
end);

InstallMethod(GenLatexTmpl, "for matrix groups", true,
[ IsMatrixGroup ], 0,
function ( g )
	local str, i;
	str := "\\left\\langle ";

	for i in [1..Length(GeneratorsOfGroup(g))] do
		str := Concatenation(str, "{},");
	od;
	str := Concatenation(str{[1..Length(str)-1]}, " \\right\\rangle");

	return str;
end);

InstallMethod(GenLatexTmpl, "for permutation groups", true,
[ IsPermGroup ], 0,
function ( g )
	local str, i;
	str := "\\left\\langle ";

	for i in [1..Length(GeneratorsOfGroup(g))] do
		str := Concatenation(str, "{},");
	od;
	str := Concatenation(str{[1..Length(str)-1]}, " \\right\\rangle");

	return str;
end);

InstallMethod(GenLatexTmpl,"assoc word in letter rep",true,
[IsAssocWord and IsLetterAssocWordRep], 0,
function( elm )
	return "{}";
end);

#############################################################################
##
#F  CtblEntryLatex( <character table entry data string> ) . 
##  
## generates a string that specifies any specific environments to be used for
## a character table entry.
##
InstallGlobalFunction(CtblEntryLatex,
function ( entry )
	if '/' in entry then
		return Concatenation(ReplacedString(entry, "/", "\\bar{"), "}");
	fi;
	return entry;
end);

#############################################################################
##
#F  CtblLegendLatex( <character table entry data record> ) . 
##  
## generates a legend that specifies what substitutions have been used in a
## representation of the character table. Uses the align environment.
##
InstallGlobalFunction(CtblLegendLatex,
function ( data ) 
	local ret, irrstack, irrnames, i, q;
	ret := "";

	irrstack := data.irrstack;
	if not IsEmpty(irrstack) then
		Info(InfoTypeset, 2, "To use the aligned LaTeX environment in table legends, add the amsmath package to your premable \\usepackage{amsmath}");
		irrnames := data.irrnames;
		Append(ret, "\\\\\n\\begin{aligned}\n");
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
		Append(ret, "\\end{aligned}");
	fi;

	return ret;
end);

#############################################################################
##
#F  GenNameAssocLetterLatex( <assoc generator string> ) . 
##  
## constructs a string containing LaTeX specific subscript notation for names
## used within associative words.
##
InstallGlobalFunction(GenNameAssocLetterLatex,
function ( s )
	local e;
	e := Length(s);
	while e>0 and s[e] in CHARS_DIGITS do
		e := e-1;
	od;
	if e<Length(s) then
		s := Concatenation(s{[1..e]},"_{",s{[e+1..Length(s)]},"}");
	fi;

	return s;
end);

#############################################################################
##
#F  FactoriseAssocWordLatex( <assoc word in letter rep>, <letter names>, <used numbers> ) . 
##  
## constructs a string based on the return values from FindSubstringPowers
## and the names of the letters.
##
InstallGlobalFunction(FactoriseAssocWordLatex,
function ( l, names, tseed )
	local n, a, substr, i, ret, exp, t, word, j;

	n := Length(names);
	if Length(l) > 0 and n=infinity then
      n := 2 * (Maximum(List(l, AbsInt))+1);
    fi;
    a := FindSubstringPowers(l, n + Length(tseed)); # tseed numbers are used already

	# FindSubstringPowers returns a 2 element list.
	# Element 1: List of substring IDs which when concatenated will result in the original word.
	# Element 2: IDs of substrings which are constructed from individual letters.
	substr := a[1];
	a[2] := Concatenation(tseed, a[2]);

	i := 1;
	ret := "";
	while i <= Length(substr) do
		exp := 1;
		if substr[i] > n then
			# Can extract the component IDs from the second entry in a
			t := a[2][substr[i] - n];
			if t[1] = 0 then
				# Single letter raised to a power
				if t[2] < 0 then
					Append(ret, names[-t[2]]);
	  				Append(ret, "^{-" );
	  				Append(ret, TypesetInternal(t[3]));
					Append(ret, "}");
				else
					Append(ret, names[-t[2]]);
	  				Append(ret, "^{" );
	  				Append(ret, TypesetInternal(t[3]));
					Append(ret, "}");
				fi;
			else
				# Constructed substring from multiple letter names
				Add(ret, '(');
				Append(ret, FactoriseAssocWordLatex(t, names, Filtered(a[2],x->x[1]=0)));
				Add(ret, ')');
			fi;
		elif substr[i] < 0 then
			Append(ret, names[-substr[i]]);
			exp := -1;
		else
			Append(ret, names[substr[i]]);
		fi;

		if i < Length(substr) and substr[i]=substr[i+1] then
			# Consume duplicates of substring
      		j := i;
      		i := i+1;

      		while i <= Length(substr) and substr[j]=substr[i] do
				i := i+1;
      		od;
      		Append(ret, "^{");
      		Append(ret, TypesetInternal(exp*(i-j)));
			Append(ret, "}");
    	elif exp=-1 then
			# Inverse power
      		Append(ret, "^{-1}");
      		i := i+1;
    	else
      		# No power given
      		i := i+1;
    	fi;
	od;
	ConvertToStringRep(ret);

	return ret;
end);
