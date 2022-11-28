#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter Digraphs Integration
#!
#! typeset is a package that implements an operation Typeset that can
#! generate LaTeX string representations of a commonly used subset
#! of mathematical objects within the GAP system.
#!
#! Typeset is also built to be incredibly extensible, and can be easily
#! extended to also support the generation of strings for other mark-up
#! languages.
#!
#! @Section Added Constants and Methods

#! @Description
#!   Default command-line options passed to the `dot2tex` executable
#!   to convert dot strings.
DeclareGlobalVariable("DEFAULT_DOT2TEX_OPTIONS",
    "List of default command-line options passed to dot2tex when converting dot snippets.");

#! @Description
#!   Executes `dot2tex` on the dot string representing a
#!   given digraph object.
#! 
#! @Returns
#!   Tikz string representation of digraph.
DeclareGlobalFunction("Dot2Tex");