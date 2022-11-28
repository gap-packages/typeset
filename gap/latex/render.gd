#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter Rendering LaTeX Strings
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
#!   RenderLatex renders a given LaTeX string in a LaTeX environment,
#!   providing a visual example of what the string would look like
#!   in a paper.
DeclareGlobalFunction("RenderLatex");

#! @Description
#!   PDFLatex renders a given LaTeX string in a new PDF file,
#!   specifically via the pdflatex bash tool.
DeclareGlobalFunction("PDFLatex");

#! @Description
#!   MathJax renders a given LaTeX string in a LaTeX environment,
#!   specifically via the MathJax script with HTML.
DeclareGlobalFunction("MathJax");

#! @Description
#!   Overleaf renders a given LaTeX string in a new Overleaf project,
#!   specifically via a URL-encoded snippet.
DeclareGlobalFunction("Overleaf");

#! @Section Utility Functions

#! @Description
#!   URIEncodeComponent replaces reserved characters within a URI
#!   component as per RFC-3986.
DeclareGlobalFunction("URIEncodeComponent");

#! @Section Constants

#! @Description
#!   Default LaTeX preamble string used for creating
#!   compilable TeX files from LaTeX snippets.
DeclareGlobalVariable("DEFAULT_LATEX_PREAMBLE",
    "Default LaTeX preamble used for creating compilable TeX files from snippets.");

#! @Description
#!   Default HTML document and head tags used to create
#!   HTML files using MathJax to render LaTeX snippets.
DeclareGlobalVariable("DEFAULT_MATHJAX_TAGS",
    "Default HTML document and head tags used to create HTML files using MathJax to render LaTeX snippets.");

#! @Description
#!   String containing all of the characters that do not
#!   need to be percent-encoded within URI components,
#!   as per RFC-3986.
DeclareGlobalVariable("ALWAYS_UNESCAPED_CHARS",
    "Reserved characters in URIs that do not need to be percent encoded.");