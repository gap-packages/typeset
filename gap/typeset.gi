#############################################################################
##
#F  Typeset( <object> ) . 
##  
## produces a typesettable string representing the provided object.
##
InstallGlobalFunction(Typeset,
function( x, opts... )
	local options, defaults, name, val, string, old;

	options := rec();
	if IsEmpty(opts) and ValueOption("options") = fail then
		Info(InfoTypeset, 3, "Generating options record from default parameters");
		
		# Merge default options with user-passed GAP options (if any).
		for name in RecNames(DEFAULT_TYPESET_OPTIONS) do
			if ValueOption(name) = fail then
				options.(name) := DEFAULT_TYPESET_OPTIONS.(name);
			else
				val := ValueOption(name);

				# Explicitly convert characters to strings for easier handling later.
				if IsChar(val) then
					val := [val];
				fi;

				options.(name) := val;
			fi;
		od;
	else
		if Length(opts)>=1 then
			# User passed optional argument, assume first is options record.
			options := opts[1];
			if Length(opts) > 1 then
				# Throw error
				Error("More than one optional argument passed.");
			fi;
		elif ValueOption("options") <> fail then
			# User passed GAP option 'options' record
			options := ValueOption("options");
		fi;

		# Pre-constructed options records may not be perfectly populated, so merge with defaults.
		for name in RecNames(DEFAULT_TYPESET_OPTIONS) do
			if not IsBound(options.(name)) then
				options.(name) := DEFAULT_TYPESET_OPTIONS.(name);
			fi;
		od;
	fi;

	# Determine function to create output string (based on lang option).
	string := TypesetInternal(x : options := options);
	Add(string, '\n');

	if options.("ReturnStr")=false then
		# Print to terminal (use SetPrintFormattingStatus to remove line breaks).
		old := PrintFormattingStatus("*stdout*");
		SetPrintFormattingStatus("*stdout*", false);
		PrintFormattedString(string);
		SetPrintFormattingStatus("*stdout*", old);
	else
		return string;
	fi;
end);

#############################################################################
##
#F  TypesetInternal( <object> ) . 
##  
## produces a typesetable string representing the provided object.
##
InstallGlobalFunction(TypesetInternal,
function( x )
	local options, lang, t, string, args, tmpl;
	
	# Backup default options setting for users who use TypesetInternal directly.
	options := ValueOption("options");
	if options=fail then
		Info(InfoTypeset, 3, "No options provided to TypesetInternal method, using defaults");
		options := ShallowCopy(DEFAULT_TYPESET_OPTIONS);
	fi;

	# Determine template string generation function.
	lang := options.("Lang");
	lang[1] := UppercaseChar(lang[1]);
	t := EvalString(Concatenation("Gen", lang, "Tmpl"));

	# Generate and populate template string.
	tmpl := t(x : options := options);
	args := GenArgs(x : options := options);
	Add(args, tmpl, 1);

	string := CallFuncList(StringFormatted, args);
	return string;
end);

#############################################################################
##
#M  GenArgs( <object> ) . 
##  
## produces a list of objects representing the semantics of the provided object.
## used to populate the template string.
##
InstallMethod(GenArgs, "fallback default method", true,
[ IsObject ], 0, 
function ( obj )
	# For some objects, simply calling ViewString(obj) may already be typesettable
	Info(InfoTypeset, 2, "Could not find installed typesetting method for object filter, falling back to ViewString()");
	return [ViewString(obj)];
end);

InstallMethod(GenArgs, "rational", true,
[ IsRat ], 0,
function ( x )
	if IsInt(x) then
    	return [ String(x) ];
  	else
		return [ NumeratorRat(x), DenominatorRat(x) ];
	fi;
end);

InstallMethod(GenArgs, "infinity", true,
[ IsInfinity ], 0,
function ( inf )
	# Infinity is normally handled via a special language-specific macro (e.g. \infty for LaTeX).
	# Therefore, rely on Gen<lang>Tmpl to return macro.
	return [];
end);

InstallMethod(GenArgs, "negative infinity", true,
[ IsNegInfinity ], 0,
function ( inf )
	# Same reasoning as infinity.
	return [];
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
			ret[2] := Concatenation("^{", TypesetInternal(deg), "}");
		fi;

		log := LogFFE(ffe,Z( char ^ deg ));
		if log <> 1 then
			ret[3] := Concatenation("^{", TypesetInternal(log), "}");
		fi;
	fi;

	return ret;
end);

InstallMethod(GenArgs, "permutation", true,
[ IsPerm ], 0,
function( perm )
	local ret, i, j, maxpnt, blist, subOptions;
	ret := [];
	subOptions := MergeSubOptions(ValueOption("options"));

  	if not IsOne( perm ) then
      	maxpnt := LargestMovedPoint(perm);
      	blist := BlistList([1..maxpnt], []);
      	for i  in [1 .. LargestMovedPoint(perm)] do
      		if not blist[i] and i ^ perm <> i  then
          		blist[i] := true;
          		Add(ret, TypesetInternal(i : options := subOptions));
          		j := i ^ perm;
          		while j > i do
          			blist[j] := true;
          			Add(ret, TypesetInternal(j : options := subOptions));
          			j := j ^ perm;
          		od;
      		fi;
      	od;
  	fi;
	
  	return ret;
end );

InstallMethod(GenArgs, "list", true,
[ IsList ], 0,
function ( lst )
	local i, r, subOptions;
	subOptions := MergeSubOptions(ValueOption("options"));

	r := [];
	for i in [1..Length(lst)] do
		Add(r, TypesetInternal(lst[i] : options := subOptions));
	od;

	return r;
end);

InstallMethod(GenArgs, "matrix", true,
[ IsMatrix ], 0,
function ( m )
	local i, j, l, n, r, opts, subOptions;
	opts := ValueOption("options");
	subOptions := MergeSubOptions(opts);

	if(opts.("MatAsList")) then
		TryNextMethod();
	fi;

	l:=Length(m);
  	n:=Length(m[1]);
	r := [];

	for i in [1..l] do
		for j in [1..n] do
			Add(r, TypesetInternal(m[i][j] : options := subOptions));
		od;
	od;

	return r;
end);

InstallMethod(GenArgs, "polynomials", true,
[ IsPolynomial ], 0, 
function( poly )
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
			Add(r, TypesetInternal(ext[i + 1] : options := subOptions));
			c := true;
		fi;

		if Length(ext[i]) > 1 then
			for j in [ 1, 3 .. Length(ext[i]) - 1] do
				if 1 <> ext[i][j + 1] then
					Add(r, TypesetInternal(ext[i][j + 1] : options := subOptions));
				fi;
			od;
		else
			if c=false then
				Add(r, TypesetInternal(ext[i + 1] : options := subOptions));
			fi;
		fi;
	od;

	return r;
end);

InstallMethod(GenArgs, "rational functions (non-polynomial)", true,
[ IsRationalFunction ], 0,
function( ratf )
	local num, den;
	num := NumeratorOfRationalFunction(ratf);
	den := DenominatorOfRationalFunction(ratf);

	return [ TypesetInternal(num), TypesetInternal(den) ];
end);

InstallMethod(GenArgs, "character tables", true,
[ IsCharacterTable ], 0,
function( tbl )
	local opts, lang, ret, chars, data, i, j, entry, entryfmt, legend;
	opts := ValueOption("options");
	lang := opts.("Lang");

	ret := [];
	chars := List(Irr(tbl), ValuesOfClassFunction);
	data := CharacterTableDisplayStringEntryDataDefault(tbl);

	# Generate character substitutions.
	for i in [1..Length(chars)] do
		for j in [1..Length(chars[i])] do
			entry := CharacterTableDisplayStringEntryDefault(chars[i][j], data);
			entryfmt := EvalString(Concatenation("CtblEntry", lang));
			Add(ret, entryfmt(entry));
		od;
	od;

	# Generate Legend.
	legend := EvalString(Concatenation("CtblLegend", lang));
	Add(ret, legend(data));

	return ret;
end);

InstallMethod(GenArgs, "fp groups", true, [ IsFpGroup ], 0,
function ( g )
	local lst, gens, rels, i, s, e, j;
	lst := [];
	gens := GeneratorsOfGroup(g);
	rels := RelatorsOfFpGroup(g);

	# Sub-powers for generators.
	for i in [1..Length(gens)] do
		s := String(gens[i]);
		e := Length(s);

		while e>0 and s[e] in CHARS_DIGITS do
			e := e-1;
		od;

		if e<Length(s) then
			Add(lst, s{[1..e]});
			Add(lst, s{[e+1..Length(s)]});
		else
			Add(lst, String(s));
		fi;
	od;

	for j in [1..Length(rels)] do
		Add(lst, TypesetInternal(rels[j]));
	od;

	return lst;
end);

InstallMethod(GenArgs, "pc groups", true, [ IsPcGroup ], 0,
function ( g )
	local lst, iso, fp;
	iso := IsomorphismFpGroupByPcgs(FamilyPcgs(g), "f");
	fp := Image(iso);

	lst := GenArgs(fp);

	return lst;
end);

InstallMethod(GenArgs, "matrix groups", true, [ IsMatrixGroup ], 0,
function ( g )
	local lst, gens, i;
	lst := [];
	gens := GeneratorsOfGroup(g);

	for i in [1..Length(gens)] do
		Add(lst, TypesetInternal(gens[i]));
	od;

	return lst;
end);

InstallMethod(GenArgs, "permutation groups", true, [ IsPermGroup ], 0,
function ( g )
	local lst, gens, i;
	lst := [];
	gens := GeneratorsOfGroup(g);

	for i in [1..Length(gens)] do
		Add(lst, TypesetInternal(gens[i]));
	od;

	return lst;
end);

InstallMethod(GenArgs,"assoc word in letter rep",true,
[IsAssocWord and IsLetterAssocWordRep],0,
function( elm )
	local opts, lang, orig, names, new, i, e, s, l, substr, factorise;
	opts := ValueOption("options");
	lang := opts.("Lang");

	# Generate names using subscript over . notation
	orig := FamilyObj(elm)!.names;
	new := ShallowCopy(orig);
	names := EvalString(Concatenation("GenNameAssocLetter", lang));
	for i in [1..Length(new)] do
		new[i] := names(new[i]);
	od;

	# Factorise word as power of substrings
	l := LetterRepAssocWord(elm);
	factorise := EvalString(Concatenation("FactoriseAssocWord", lang));
	substr := factorise(l, new, []);

	return [ substr ];
end);

#############################################################################
##
#F  MergeSubOptions( <current options record> ) . 
##  
## generates a new options record that can be passed to sub-calls from a parent.
## used to allow users to set options that may differ between recursive calls
## of a single method (e.g. Matrix delimitors).
##
InstallGlobalFunction(MergeSubOptions,
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

#############################################################################
##
#V  DEFAULT_TYPESET_OPTIONS . 
##  
## 	List of default optional arguments passed to the Typeset method.
##
InstallValue(DEFAULT_TYPESET_OPTIONS,
	rec(
		ReturnStr := false, LDelim := "(", RDelim :=")",
		Lang := "latex", DigraphOut := "dot", SubCallOpts := false,
		MatAsList := false,
	)
);
