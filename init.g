#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# Reading the declaration part of the package.
#
ReadPackage( "latexgen", "gap/typeset.gd" );
ReadPackage( "latexgen", "gap/latex/latex.gd" );
ReadPackage( "latexgen", "gap/latex/structdesc.gd" );
ReadPackage( "latexgen", "gap/latex/render.gd" );
if IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
    ReadPackage( "latexgen", "gap/latex/digraphs.gd");
fi;