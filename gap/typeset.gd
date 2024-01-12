#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter Introduction
#! @Section Core Framework Functions
#!
#! <Package>typeset</Package> is a package that implements a typesetting framework
#! that can be implemented for numerous typesetting languages as a standardised
#! way to generate renderable strings.
#!
#! At it's core, it implements the function <Ref Func="Typeset" /> which
#! makes use of typesetting language-specific functions to generate format
#! strings. These strings are then populated with a list of the semantic
#! features of the &GAP; objects they represent, which is obtained from the
#! operation <Ref Oper="GenArgs" Label="for IsObject" />.
#!
#! An example implementation of this framework is also provided by this
#! package for LaTeX typesetting within chapter <Ref Chap="Chapter_LaTeX_Generation" />.
#!
#! Guidelines for extending the framework to support more types, or for
#! implementing the framework for another typesetting language can
#! be found within the contributing guidelines in the GitHub repository.
#!
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
#!      * `SubCallOpts`   : Alternate &GAP; options for nested sub-objects, via
#!                          a record with the same options as the parent
#!                          (but different values), or `false` if all options are
#!                          to stay the same between sub-calls. Options merging is
#!                          handled by <Ref Func="MergeSubOptions" />.       (default - `false`)
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
#!   A String, if `ReturnStr` option is set to `true`
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
#!   mark-up language. If no method is installed for a type, it will fallback to returning the
#!   list [ ViewString(obj) ].
#!
#! @Arguments obj
#!
#! @Returns
#!  A List of Strings
DeclareOperation("GenArgs", [ IsObject ]);

#! @Section Constants and Utility Functions
#! @Description
#!   Merges the passed options record <A>opts</A> to change any values that are set in the &GAP; option
#!   `SubCallOpts`. If this option is not false (default), it can contain a record of any &GAP; options
#!   that can be passed to <Ref Func="Typeset" /> which should differ for sub-calls.
#!
#!   For example, to alter the delimiters for nested objects so that the outer object is delimited by
#!   square braces and the inner object by parentheses, the following can be set:
#!
#! @BeginExampleSession
#! gap> MergeSubOptions(rec(ReturnStr := false, Lang := "latex", DigraphOut := "dot", RDelim := "]", LDelim := "[", SubCallOpts := rec(RDelim := ")", LDelim := "(")));
#! rec(ReturnStr := false, Lang := "latex", DigraphOut := "dot", RDelim := ")", LDelim := "(", SubCallOpts := false)
#! @EndExampleSession
#!
#!  It should be noted that `SubCallOpts` only changes the options for one level of recursion (i.e. it is set back
#!  to the default of `false` once this function is called). To change options for more recursion levels, the
#!  `SubCallOpts` option can be nested as many times as necessary.
#!
#! @Arguments opts
#!
#! @Returns
#!  A Record
DeclareGlobalFunction("MergeSubOptions");

#! @Description
#!   Default options record passed to <Ref Func="Typeset" />. Merged with user-provided
#!   options to ensure correct construction of options for sub-calls,
#!   whilst also allowing option-less calls to the method.
DeclareGlobalVariable("DEFAULT_TYPESET_OPTIONS");
