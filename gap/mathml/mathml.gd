#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter MathML Example Generation
#! @Section MathML Generation Functions for &GAP; Objects
#!
#! This section describes a bare-bones implementation of the framework for generating MathML
#! representations. It is intended to be used as a reference for implementing the framework,
#! and as a starting point for implementing the framework for other languages - not as a fully
#! functional implementation of the framework.

#! @Description
#!   Generates a format string that represents the structural definition of the given &GAP;
#!   object <A>obj</A> in MathML. It contains no parameter values, and will need to be
#!   populated with the arguments representing the semantic values of the object, generated
#!   via <Ref Oper="GenArgs" Label="for IsObject" />, before it can be rendered in a MathML environment.
#!
#! @Arguments obj
#!
#! @Returns
#!   An Unpopulated MathML Format String
DeclareOperation("GenMathmlTmpl", [ IsObject ]);
