#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# Reading the declaration part of the package.
#
ReadPackage( "latexgen", "gap/typeset.gi" );
ReadPackage( "latexgen", "gap/latex.gd");
ReadPackage( "latexgen", "gap/structdesc.gd");
ReadPackage( "latexgen", "gap/render.gd");
if IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
    ReadPackage( "latexgen", "gap/digraphs.gd");
fi;