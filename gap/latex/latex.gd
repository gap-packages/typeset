#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter &LaTeX; Generation
#!
#! typeset is a package that implements an operation Typeset that can
#! generate LaTeX string representations of a commonly used subset
#! of mathematical objects within the GAP system.
#!
#! Typeset is also built to be incredibly extensible, and can be easily
#! extended to also support the generation of strings for other mark-up
#! languages.
#!
#! @Section LaTeX Generation for &GAP; Objects
#! @Description
#!   Generates a format string that represents the structural definition of the given &GAP;
#!   object in &LaTeX;. It contains no parameter values, and will need to be populated with
#!   the arguments representing the semantic values of the object, generated via
#!   <Ref Oper="GenArgs" BookName="typeset"/>, before it can be rendered in a &LaTeX; environment.
#!
#! @Arguments obj
#!
#! @Returns
#!   Unpopulated &LaTeX; format string representing the structural description of the passed object.
DeclareOperation("GenLatexTmpl", [ IsObject ]);

#! @Description
#!   Formats a string representation of an entry to include the &LaTeX; specific
#!   environments for complex conjugates.
#!
#! @Arguments s
#!
#! @Returns
#!  Strings that describe the character table entry in &LaTeX;.
DeclareGlobalFunction("CtblEntryLatex");

#! @Description
#!   Generates a string representation of the mathematical substitutions for entries
#!   within a character table.
#!
#! @Arguments data
#!
#! @Returns
#!  Strings that describe the calculated substitutions.
DeclareGlobalFunction("CtblLegendLatex");

#! @Description
#!   Generates a string representation of the provided letter string
#!   correctly subscripted with a &LaTeX; math-mode subscript environment.
#!
#! @Arguments s
#!
#! @Returns
#!  Strings that describe the calculated substitutions.
DeclareGlobalFunction("GenNameAssocLetterLatex");

#! @Description
#!   Factorises the string representation of an assoc word in letter representation,
#!   based on the return value from <Ref BookName="ref" Func="FindSubstringPowers" />.
#!
#! @Arguments l, names, tseed
#!
#! @Returns
#!  String describing the factorised assoc word.
DeclareGlobalFunction("FactoriseAssocWordLatex");