#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# Reading the implementation part of the package.
#
ReadPackage( "latexgen", "gap/typeset.gi" );
ReadPackage( "latexgen", "gap/latex.gi" );
ReadPackage( "latexgen", "gap/structdesc.gi" );
ReadPackage( "latexgen", "gap/render.gi" );
if IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
    ReadPackage( "latexgen", "gap/digraphs.gi");
fi;