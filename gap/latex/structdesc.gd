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
#! @Section Structure Description of Groups

#! @Description
#!   TypesetStructureDescription generates a typesettable representation equivalent to a given
#!   structure description of a group. These structure descriptions can be calculated
#!   via the method StructureDescription.
#!
#! @Returns
#!  Typesettable representation of the given structure description of a group.
DeclareOperation("TypesetStructureDescription", [ IsString ]);

#! @Description
#!   LatexStructureDescription generates a LaTeX representation equivalent to a given
#!   structure description of a group. These structure descriptions can be calculated
#!   via the method StructureDescription.
#!
#! @Returns
#!  LaTeX renderable representation of the given structure description of a group.
DeclareOperation("LatexStructureDescription", [ IsString ]);

#! @Description
#!   ConcatStructDescOperands will concatenate the tokens parsed from splitting
#!   the first input string with the provided separator. It will then process
#!   the tokens with LatexStructureDescription, and concatenate the results
#!   with the given new separator.
#!
#! @Returns
#!  Concatenated string of processed tokens with new separator.
DeclareOperation("ConcatStructDescOperands", [ IsString, IsString, IsString ]);