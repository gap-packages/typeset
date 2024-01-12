#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter LaTeX Generation
#!
#! @Section Rendering LaTeX Strings
#!
#! To aid users using <Ref Func="Typeset"/>, being able to view the results quickly in a
#! variety of widely-used formats would help streamline the usage of the package. As such,
#! a number of functions described below have been written to enable users to render the output
#! LaTeX-renderable snippets in different fashions.
#!
#! @Description
#!   Renders a given LaTeX string <A>str</A> in a LaTeX environment,
#!   providing a visual example of what the string would look like
#!   in a paper. By default, this involved creating a HTML file that
#!   includes the MathJax script, but the &GAP; option <A>output</A> can be
#!   passed to change the rendering method.
#!
#!   Currently implemented rendering methods are:
#!      * `"mathjax"`, calling <Ref Func="MathJax" />
#!      * `"pdflatex"`, calling <Ref Func="PDFLatex" />
#!      * `"overleaf"`, calling <Ref Func="Overleaf" />
#!
#!   These functions can be called independently of <Ref Func="RenderLatex"/>,
#!   which serves only to be a more centralised rendering method for users.
#!
#! @Arguments str[, options]
DeclareGlobalFunction("RenderLatex");

#! @Description
#!   Renders a given LaTeX string <A>str</A> in a new PDF file,
#!   specifically via the pdflatex bash tool.
#!
#! @Arguments str
DeclareGlobalFunction("PDFLatex");

#! @Description
#!   Renders a given LaTeX string <A>str</A> in a HTML file,
#!   making use of the MathJax and TikzJax scripts.
#!
#! @Arguments str
DeclareGlobalFunction("MathJax");

#! @Description
#!   Renders a given LaTeX string <A>str</A> in a new Overleaf project,
#!   specifically via a URL-encoded snippet.
#!
#! @Arguments str
DeclareGlobalFunction("Overleaf");

#! @Subsection Constants and Helper Functions
#! @Description
#!   Replaces reserved characters within a URI
#!   component <A>raw</A> as per RFC-3986.
#!
#! @Arguments raw
#!
#! @Returns
#!  A Percent-Encoded String
DeclareGlobalFunction("URIEncodeComponent");

#! @Description
#!   Determines if the LaTeX snippet <A>raw</A> requires
#!   LaTeX's math mode to be rendered correctly.
#!
#! @Arguments raw
#!
#! @Returns
#!  A Boolean
DeclareGlobalFunction("NeedsLatexMathMode");

#! @Description
#!   Default LaTeX preamble string used for creating
#!   compilable `.tex` files from LaTeX snippets.
DeclareGlobalVariable("DEFAULT_LATEX_PREAMBLE");

#! @Description
#!   Default HTML document and head tags used to create
#!   HTML files using MathJax to render LaTeX snippets.
DeclareGlobalVariable("DEFAULT_MATHJAX_TAGS");

#! @Description
#!   String containing all of the characters that do not
#!   need to be percent-encoded within URI components,
#!   as per RFC-3986.
DeclareGlobalVariable("ALWAYS_UNESCAPED_CHARS");
