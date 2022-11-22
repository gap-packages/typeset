#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# Reading the implementation part of the package.
#
ReadPackage( "latexgen", "gap/latexgen.gi");
ReadPackage( "latexgen", "gap/structdesc.gi");
if IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
    ReadPackage( "latexgen", "gap/digraphs.gi");
fi;