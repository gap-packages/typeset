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
#!           &LaTeX; packages that need to be added to the preamble to be rendered.
#!     * 3 - Progress: also shows step-by-step progress of operations
#!
#!   Set this using, for example `SetInfoLevel(InfoTypeset, 1)`.
#!   Default value is 2.
DeclareInfoClass("InfoTypeset");
SetInfoLevel(InfoTypeset, 2);

#! @Description
#!   Generates a mark-up string representing the object <A>obj</A> in the given mark-up language. 
#!   &GAP; options can also be added to modify the result:
#!      * `ReturnStr`     : Whether the method should return a string (`true`),
#!                          or simply print the result (`false`).         (default - `false`)
#!      * `LDelim`        : Left Delimiter for matrices.                  (default - `"("`)
#!      * `RDelim`        : Right Delimiter for matrices.                 (default - `")"`)
#!      * `Lang`          : Markup language of output, currently only
#!                          `"latex"` is supported.                       (default - `"latex"`)
#!      * `DigraphOut`    : Typesetting method for Digraphs, one of
#!                          `"dot"` to use raw dot within TeX, or `"dot2tex"`
#!                          to convert the dot to native TeX.             (default - `"dot"`)
#!      * `SubCallOpts`   : Alternate options for nested structures, passed
#!                          as a record with the same options as the parent
#!                          (but different values), or `false` if options are
#!                          to stay the same between sub-calls.           (default - `false`)
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
#! or even simply passing a record object as the optional second argument:
#!
#! @BeginExampleSession
#! gap> Typeset([[1, 2], [2, 1]], rec(LDelim := "[", ReturnStr := true));
#! "\\left[\\begin{array}{rr}\n1 & 2 \\\\\n2 & 1 \\\\\n\\end{array}\\right)\n"
#! @EndExampleSession
#!
#! @Arguments obj[, options]
#! 
#! @Returns
#!   A String, if `ReturnStr` option is set to `true`.
DeclareGlobalFunction("Typeset");

#! @Description
#!   Generates a string representation of a passed &GAP; object <A>obj</A> that
#!   can be rendered by a typesetter. Called from the top-level method
#!   <Ref Func="Typeset" />, which also passes a constructed options
#!   record as the `options` &GAP; option.
#!
#! @Arguments obj
#!
#! @Returns
#!   A String
DeclareGlobalFunction("TypesetInternal");

#! @Section Core Operations
#! @Description
#!   Generates the arguments describing the semantic definition of the passed &GAP;
#!   object <A>obj</A>. This returns a list that can be used to populate a format string in any
#!   mark-up language.
#!
#! @Arguments obj
#!
#! @Returns
#!  A List of Strings
DeclareOperation("GenArgs", [ IsObject ]);

#! @Section Constants and Utility Functions
#! @Description
#!   Merges the passed options records passed optionally within a function call to
#!   <Ref Oper="GenArgs" />. It allows for the `SubCallOpts` record value to specify any
#!   option values that should be altered on nested sub-calls when generating typesetting strings.
#!
#! @Arguments currOptions
#!
#! @Returns
#!  A Record
DeclareGlobalFunction("MergeSubOptions");

#! @Description
#!   Default options record passed to <Ref Func="Typeset" />. Merged with user-provided
#!   options to ensure correct construction of options for sub-calls,
#!   whilst also allowing option-less calls to the method.
DeclareGlobalVariable("DEFAULT_TYPESET_OPTIONS",
    "Default options record for the Typeset method.");