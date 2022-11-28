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
#! @Section Core Functions
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
#!   that object in the given mark-up language. GAP options can also
#!   be added to modify the result:
#!      * `ReturnStr`     : Whether the method should return a string     (default - `false`)
#!      * `LDelim`        : Left Delimiter for matrices                   (default - `"("`)
#!      * `RDelim`        : Right Delimiter for matrices                  (default - `")"`)
#!		* `Lang`          : Markup language of output                     (default - `"latex"`)
#!      * `DigraphOut`    : Typesetting method for Digraphs               (default - `"dot"`)
#!      * `SubCallOpts`   : Alternate options for nested structures       (default - `false`)
#!  either by specifying each options as an individual GAP options like below:
#!
#! @BeginExampleSession
#! gap> Typeset([[1, 2], [2, 1]] : LDelim := "[", ReturnStr := true);
#! "\\left[\\begin{array}{rr}\n1 & 2 \\\\\n2 & 1 \\\\\n\\end{array}\\right)\n"
#! @EndExampleSession
#!
#!  or wrapping them in a record under an `options` GAP option, like:
#!  
#! @BeginExampleSession
#! gap> Typeset([[1, 2], [2, 1]] : options := rec(LDelim := "[", ReturnStr := true));
#! "\\left[\\begin{array}{rr}\n1 & 2 \\\\\n2 & 1 \\\\\n\\end{array}\\right)\n"
#! @EndExampleSession
#!
#! @Arguments obj : options
#! 
#! @Returns
#!   String representation of object in given mark-up language.
DeclareGlobalFunction("Typeset");

#! @Description
#!   TypesetInternal generates a string representation of a passed mathematical object that
#!   can be rendered by a typesetter.
#!
#! @Returns
#!   Typesetable String representation of object.
DeclareGlobalFunction("TypesetInternal");

#! @Description
#!   MergeSubOptions will merge the options records passed optionally within a function call to
#!   GenArgs. It allows for the subOpts record value to specify any option values that should
#!   be altered on nested subcalls when generating typesetting strings.
#!
#! @Returns
#!  Records representing the options that should be passed to any sub calls within the current method.
DeclareGlobalFunction("MergeSubOptions");

#! @Section Core Operations
#! @Description
#!   GenArgs generates the arguments describing the semantic definition of the passed mathematical
#!   object. This should result in a list that can be used to populate a format string in any
#!   mark-up language.
#!
#! @Returns
#!  List of strings that describe the semantic structure of an object.
DeclareOperation("GenArgs", [ IsObject ]);

#! @Section Constants
#! @Description
#!   
DeclareGlobalVariable("DEFAULT_TYPESET_OPTIONS",
    "Default options record for the Typeset method.");