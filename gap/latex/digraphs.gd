#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter LaTeX Generation
#! @Section Digraphs Integration
#!
#! <Package>digraphs</Package> is a powerful, widely-used packages, implementing
#! helpful functionality to work with directed graphs amongst other objects. Due to
#! it's popularity, and as a way to demonstrate how <Package>typeset</Package> can
#! be integrated with external packages, the following functions have been implemented
#! to allow directed graphs to be converted into LaTeX representations.
#!
#! It should be noted that the conversion implemented here does use the output from
#! <Ref BookName="digraphs" Func="DotDigraph" />, which generates the DOT string
#! representing a digraph. This is then used to either convert it to a tikz representation
#! via the command-line tool dot2tex (using the &GAP; option `digraphOut := "dot2tex"`), or
#! simply wrapping it up in a dot2tex environment provided by the LaTeX package dot2texi
#! which will compile the wrapped DOT input into tikz during compilation of the LaTeX file
#! itself.
#!
#! While another method could be written to convert the internal representation of a directed
#! graph directly into a tikzpicture, this would likely be incredibly convoluted and difficult,
#! and may present numerous problems with edge positioning. Therefore, relying on dot2tex was chosen
#! as the best approach.
#!
#! @Description
#!   Default command-line options passed to the `dot2tex` executable
#!   to convert dot strings.
DeclareGlobalVariable("DEFAULT_DOT2TEX_OPTIONS");

#! @Description
#!   Executes `dot2tex` on the dot string representing a
#!   given digraph object <A>obj</A>.
#!
#! @Arguments obj
#! 
#! @Returns
#!   A Tikz String
DeclareGlobalFunction("Dot2Tex");
