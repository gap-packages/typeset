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