#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter Digraphs
#!
#! typeset is a package that implements an operation Typeset that can
#! generate LaTeX string representations of a commonly used subset
#! of mathematical objects within the GAP system.
#!
#! Typeset is also built to be incredibly extensible, and can be easily
#! extended to also support the generation of strings for other mark-up
#! languages.
#!
#! @Section External Integration

#! @Description
#!   Dot2Tex executes dot2tex on the dot string representing a
#!   given digraph object.
#! 
#! @Returns
#!   Tikz string representation of digraph.
DeclareOperation("Dot2Tex", [ IsDigraph ]);