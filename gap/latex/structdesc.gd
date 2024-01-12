#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter Structure Descriptions
#!
#! While <Ref BookName="ref" Func="StructureDescription"/> provides powerful functionality
#! in calculating the structure description of an input group, the returned string is simply
#! raw text, and does not look good when rendered in typical typesetting environment.
#!
#! To improve this, the following functions have been written to help convert the structure
#! description strings into typesettable representations, that use language-specific features
#! to ensure that displaying structure descriptions aesthetically is easy and efficient.
#!
#! @Section Typesetting Structure Descriptions of Groups
#! @Description
#!   Generates a typesettable representation equivalent to a given
#!   structure description <A>desc</A> of a group. Said structure descriptions
#!   can be calculated via <Ref BookName="ref" Func="StructureDescription"/>.
#!
#! @Arguments desc
#!
#! @Returns
#!  A String
DeclareGlobalFunction("TypesetStructureDescription");

#! @Description
#!   Generates a LaTeX representation equivalent to a given structure description
#!   <A>desc</A>. Called by <Ref Func="TypesetStructureDescription"/> as the
#!   default markup language for structure description typesetting.
#!
#! @Arguments desc
#!
#! @Returns
#!  A String
DeclareGlobalFunction("LatexStructureDescription");

#! @Description
#!   Concatenates the tokens parsed from splitting the string <A>desc</A> with the
#!   provided separator string <A>sep</A>. It will then process the tokens
#!   with <Ref Func="LatexStructureDescription"/>, and concatenate the
#!   results with the given new separator <A>newsep</A>.
#!
#! @Arguments desc, sep, newsep
#!
#! @Returns
#!  A String
DeclareGlobalFunction("ConcatStructDescOperands");
