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
#!   Typeset takes a mathematical object and generates a mark-up string representing
#!   that object in the given mark-up language (default: LaTeX). Optional records can
#!   be added to modify the result:
#!      < list of optional parameters >
#! 
#! @Returns
#!   String representation of object in given mark-up language.
DeclareOperation("Typeset", [ IsObject ]);

#! @Description
#!   LatexString generates a string representation of a passed mathematical object that
#!   can be rendered by a LaTeX typesetter.
#!
#! @Returns
#!   String representation of objet in LaTeX.
DeclareOperation("LatexString", [ IsObject ]);

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
#!   MergeSubOptions will merge the options records passed optionally within a function call to
#!   GenArgs. It allows for the subOpts record value to specify any option values that should
#!   be altered on nested subcalls when generating typesetting strings.
#!
#! @Returns
#!  Records representing the options that should be passed to any sub calls within the current method.
DeclareOperation("MergeSubOptions", [ IsRecord ]);
