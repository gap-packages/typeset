#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter LaTeX Generation
#! @Section LaTeX Generation Functions for &GAP; Objects
#!
#! The introduction in <Ref Sect="Chapter_Introduction_Section_Core_Framework_Functions" /> 
#! describes a powerful framework created in this package allowing for a standardised
#! methodology to generate typesetting strings via the semantic features of objects.
#!
#! This section describes the implementation of the framework for LaTeX, providing both
#! the invaluable functionality to typeset a subset of &GAP; objects as LaTeX strings
#! whilst also serving as an example of how the framework can be used for other typesetting
#! languages. 
#!
#! It also provides some insight into the kinds of functions that would be expected
#! from an implementation for a different language.
#!
#! Currently, the following types have explicit methods installed for LaTeX generation:
#!  
#!  * Rationals (Integers and Fractions)
#!  * Infinity and Negative Infinity
#!  * Internal Finite-Field Elements
#!  * Permutations
#!  * Matrices
#!  * Polynomials and Non-Polynomial Rational Functions
#!  * Character Tables
#!  * Generators for FP, PC, Matrix and Permutation Groups
#!  * Associative Words in Letter Representation
#!
#! It should also be noted that <Ref Func="Typeset" /> does fallback to the core library
#! function <Ref BookName="ref" Func="ViewString" />, which can be used for any types which
#! do not require LaTeX-specific formatting to be renderable in math mode (e.g. floats).

#! @Description
#!   Generates a format string that represents the structural definition of the given &GAP;
#!   object <A>obj</A> in LaTeX. It contains no parameter values, and will need to be
#!   populated with the arguments representing the semantic values of the object, generated
#!   via <Ref Oper="GenArgs" Label="for IsObject" />, before it can be rendered in a LaTeX environment.
#!
#! @Arguments obj
#!
#! @Returns
#!   An Unpopulated LaTeX Format String
DeclareOperation("GenLatexTmpl", [ IsObject ]);

#! @Description
#!   Formats a string representation of an entry <A>s</A> returned by
#!   the undocumented function `CharacterTableDisplayStringEntryDefault`
#!   to include the LaTeX-specific bar environment for complex conjugates.
#!
#! @Arguments s
#!
#! @Returns
#!  A String
DeclareGlobalFunction("CtblEntryLatex");

#! @Description
#!   Generates a string representation of the mathematical substitutions <A>data</A>,
#!   generated by the undocumented function `CharacterTableDisplayStringEntryDataDefault`
#!   for entries within a character table.
#!
#! @Arguments data
#!
#! @Returns
#!  A String
DeclareGlobalFunction("CtblLegendLatex");

#! @Description
#!   Generates a string representation of the provided letter string <A>s</A>
#!   correctly subscripted with a LaTeX math-mode subscript environment.
#!
#! @Arguments s
#!
#! @Returns
#!  A String
DeclareGlobalFunction("GenNameAssocLetterLatex");

#! @Description
#!   Factorises the string representation of an assoc word in letter representation <A>l</A>,
#!   based on the return value from the undocumented function `FindSubstringPowers`, using the
#!   passed list of letters <A>names</A>, and a list of reserved numbers <A>tseed</A> (typically
#!   empty for initial calls).
#!
#!   This method is essentially a LaTeX-specific implementation of the the undocumented function
#!   `NiceStringAssocWord`.
#!
#! @Arguments l, names, tseed
#!
#! @Returns
#!  A Factorised String
DeclareGlobalFunction("FactoriseAssocWordLatex");