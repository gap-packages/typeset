#
# typeset: Automatic LaTeX string generation for common GAP objects
#
# Reading the declaration part of the package.
#
ReadPackage( "typeset", "gap/typeset.gd" );
ReadPackage( "typeset", "gap/latex/latex.gd" );
ReadPackage( "typeset", "gap/latex/structdesc.gd" );
ReadPackage( "typeset", "gap/latex/render.gd" );
if IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
    ReadPackage( "typeset", "gap/latex/digraphs.gd");
fi;