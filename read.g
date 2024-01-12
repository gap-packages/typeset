#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
# Reading the implementation part of the package.
#
ReadPackage( "typeset", "gap/typeset.gi" );
ReadPackage( "typeset", "gap/latex/latex.gi" );
ReadPackage( "typeset", "gap/latex/structdesc.gi" );
ReadPackage( "typeset", "gap/latex/render.gi" );
ReadPackage( "typeset", "gap/mathml/mathml.gi" );
if IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
    ReadPackage( "typeset", "gap/latex/digraphs.gi");
fi;
