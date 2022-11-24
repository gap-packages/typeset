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
#! @Section Constants
DeclareGlobalVariable("DefaultLaTeXPreamble");

DeclareGlobalVariable("AlwaysUnescapedChars");

DeclareGlobalVariable("DefaultMathJaxTags");

#! @Section Methods

#! @Description
#!   RenderLatex renders a given LaTeX string in a LaTeX environment,
#!   providing a visual example of what the string would look like
#!   in a paper.
DeclareOperation("RenderLatex", [ IsString ]);

#! @Description
#!   Overleaf renders a given LaTeX string in a new PDF file,
#!   specifically via the pdflatex bash tool.
DeclareOperation("PDFLatex", [ IsString ]);

#! @Description
#!   MathJax renders a given LaTeX string in a LaTeX environment,
#!   specifically via the MathJax script with HTML.
DeclareOperation("MathJax", [ IsString ]);

#! @Description
#!   Overleaf renders a given LaTeX string in a new Overleaf project,
#!   specifically via a URL-encoded snippet.
DeclareOperation("Overleaf", [ IsString ]);

#! @Description
#!   URIEncodeComponent replaces reserved characters within a URI
#!   component as per RFC-3986.
DeclareOperation("URIEncodeComponent", [ IsString ]);