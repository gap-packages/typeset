#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter Introduction
#!
#! typeset is a package that implements an operation Typeset that can
#! generate LaTeX string representations of a commonly used subset
#! of mathematical objects within the GAP system.
#!
#! Typeset is also built to be incredibly extensible, and can be easily
#! extended to also support the generation of strings for other mark-up
#! languages.
#!
#! @Section Core Methods

DeclareGlobalVariable("DefaultTypesetOptions",
    "Default options record for the Typeset method.");

#! @Description
#!   Info class for the <Package>typeset</Package> package.  Set this to the following
#!   levels for different levels of information:
#!     * 0 - No messages
#!     * 1 - Problems only: messages describing what went wrong, with no
#!           messages if an operation is successful
#!     * 2 - Required preamble packages: displays informations about any required
#!           LaTeX packages that need to be added to the preamble to be rendered.
#!     * 3 - Progress: also shows step-by-step progress of operations
#!
#!   Set this using, for example `SetInfoLevel(InfoTypeset, 1)`.
#!   Default value is 2.
DeclareInfoClass("InfoTypeset");
SetInfoLevel(InfoTypeset, 2);

#! @Description
#!   Typeset takes a mathematical object and generates a mark-up string representing
#!   that object in the given mark-up language. Optional records can
#!   be added to modify the result:
#!      - ReturnStr : Whether the method should return a string (default - false)
#!      - LDelim : Left Delimiter for matrices                  (default - "(")
#!      - RDelim : Right Delimiter for matrices                 (default - ")")
#!		- Lang   : Markup language of output                    (default - "latex")
#!      - DigraphOut : Typesetting method for Digraphs          (default - "dot")
#!      - SubCallOpts : Alternate options for nested structures (default - false)
#! 
#! @Returns
#!   String representation of object in given mark-up language.
DeclareOperation("Typeset", [ IsObject ]);

#! @Description
#!   TypesetInternal generates a string representation of a passed mathematical object that
#!   can be rendered by a typesetter.
#!
#! @Returns
#!   Typesetable String representation of object.
DeclareOperation("TypesetInternal", [ IsObject ]);

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
