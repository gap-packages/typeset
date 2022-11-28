#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
#! @Chapter Structure Descriptions
#!
#! typeset is a package that implements an operation Typeset that can
#! generate LaTeX string representations of a commonly used subset
#! of mathematical objects within the GAP system.
#!
#! Typeset is also built to be incredibly extensible, and can be easily
#! extended to also support the generation of strings for other mark-up
#! languages.
#!
#! @Section Typesetting Structure Descriptions of Groups
#! @Description
#!   Generates a typesettable representation equivalent to a given
#!   structure description of a group. These structure descriptions can be calculated
#!   via the function <Ref BookName="ref" Func="StructureDescription"/>.
#!
#! @Arguments desc
#!
#! @Returns
#!  Typesettable representation of the given structure description of a group.
DeclareGlobalFunction("TypesetStructureDescription");

#! @Description
#!   Generates a &LaTeX; representation equivalent to a given structure description of a group.
#!   Called by <Ref Func="TypesetStructureDescription"/> as the default markup language
#!   for structure description typesetting.
#!
#! @Arguments desc
#!
#! @Returns
#!  &LaTeX; renderable representation of the given structure description of a group.
DeclareGlobalFunction("LatexStructureDescription");

#! @Description
#!   Concatenates the tokens parsed from splitting the first input string with the
#!   provided separator. It will then process the tokens with <Ref Func="LatexStructureDescription"/>,
#!   and concatenate the results with the given new separator.
#!
#! @Arguments desc, sep, newsep
#!
#! @Returns
#!  Concatenated string of processed tokens with new separator.
DeclareGlobalFunction("ConcatStructDescOperands");