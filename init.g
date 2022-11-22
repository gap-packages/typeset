#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# Reading the declaration part of the package.
#
ReadPackage( "latexgen", "gap/latexgen.gd");
ReadPackage( "latexgen", "gap/structdesc.gd");
if IsPackageMarkedForLoading( "digraphs", "1.6.0" ) then
    ReadPackage( "latexgen", "gap/digraphs.gd");
fi;