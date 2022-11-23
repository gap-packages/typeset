#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
#! @Chapter Introduction
#!
#! latexgen is a package that implements an operation Typeset that can
#! generate LaTeX string representations of a commonly used subset
#! of mathematical objects within the GAP system.
#!
#! Typeset is also built to be incredibly extensible, and can be easily
#! extended to also support the generation of strings for other mark-up
#! languages.
#!
#! @Section Example Methods

#! @Description
#!   Info class for the <Package>latexgen</Package> package.  Set this to the following
#!   levels for different levels of information:
#!     * 0 - No messages
#!     * 1 - Problems only: messages describing what went wrong, with no
#!           messages if an operation is successful
#!     * 2 - Required preamble packages: displays informations about any required
#!           LaTeX packages that need to be added to the preamble to be rendered.
#!     * 3 - Progress: also shows step-by-step progress of operations
#!
#!   Set this using, for example `SetInfoLevel(InfoLatexgen, 1)`.
#!   Default value is 2.
DeclareInfoClass("InfoLatexgen");
SetInfoLevel(InfoLatexgen, 2);

#! @Description
#!   Typeset takes a mathematical object and generates a mark-up string representing
#!   that object in the given mark-up language (default: LaTeX). Optional records can
#!   be added to modify the result:
#!      TODO: list of optional parameters
#! 
#! @Returns
#!   String representation of object in given mark-up language.
DeclareOperation("Typeset", [ IsObject ]);

#! @Description
#!   TypesetString generates a string representation of a passed mathematical object that
#!   can be rendered by a typesetter.
#!
#! @Returns
#!   Typesetable String representation of object.
DeclareOperation("TypesetString", [ IsObject ]);

#! @Description
#!   GenLatexTmpl generates a format string that represents the structural definition
#!   of the given mathematical object in LaTeX. It contains no parameter values, and will
#!   need to be populated with the arguments representing the semantic values of the object
#!   before it can be rendered in a LaTeX environment.
#!
#! @Returns
#!   Unpopulated LaTeX format string representing the structural description of the passed object.
DeclareOperation("GenLatexTmpl", [ IsObject ]);

#! @Description
#!   GenArgs generates the arguments describing the semantic definition of the passed mathematical
#!   object. This should result in a list that can be used to populate a format string in any
#!   mark-up language.
#!
#! @Returns
#!  List of strings that describe the semantic structure of an object.
DeclareOperation("GenArgs", [ IsObject ]);

#! @Description
#!   CtblEntryLatex formats a string representation of an entry to include the LaTeX specific
#!   environments for complex conjugates.
#!
#! @Returns
#!  Strings that describe the character table entry in LaTeX.
DeclareOperation("CtblEntryLatex", [ IsString ]);

#! @Description
#!   CtblLegendLatex generates a string representation of the mathematical substitutions for entries
#!   within a character table.
#!
#! @Returns
#!  Strings that describe the calculated substitutions.
DeclareOperation("CtblLegendLatex", [ IsRecord ]);

#! @Description
#!   GenNameAssocLetterLatex generates a string representation of the provided letter string
#!   correctly subscripted with a LaTeX math-mode subscript environment.
#!
#! @Returns
#!  Strings that describe the calculated substitutions.
DeclareOperation("GenNameAssocLetterLatex", [ IsString ]);

#! @Description
#!   FactoriseAssocWordLatex generates a factorised string representation of an assoc word
#!   in letter representation, based on the return value from FindSubstringPowers.
#!
#! @Returns
#!  String describing the factorised assoc word.
DeclareOperation("FactoriseAssocWordLatex", [ IsList, IsList, IsList ]);

#! @Description
#!   MergeSubOptions will merge the options records passed optionally within a function call to
#!   GenArgs. It allows for the subOpts record value to specify any option values that should
#!   be altered on nested subcalls when generating typesetting strings.
#!
#! @Returns
#!  Records representing the options that should be passed to any sub calls within the current method.
DeclareOperation("MergeSubOptions", [ IsRecord ]);
