#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# Reading the implementation part of the package.
#
ReadPackage( "latexgen", "gap/typeset.gi" );
ReadPackage( "latexgen", "gap/latex/latex.gi" );
ReadPackage( "latexgen", "gap/latex/structdesc.gi" );
ReadPackage( "latexgen", "gap/latex/render.gi" );
if IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
    ReadPackage( "latexgen", "gap/latex/digraphs.gi");
fi;