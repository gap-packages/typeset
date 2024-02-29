#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "ctbllib" );

LoadPackage( "typeset" );

SetInfoLevel(InfoTypeset, 0);

exclude:=[];
if not IsPackageMarkedForLoading( "digraphs", "1.5.0" ) then
  Add(exclude, "latex/digraphs.tst");
fi;


# LaTeX Generation Tests
TestDirectory(DirectoriesPackageLibrary( "typeset", "tst" ),
  rec(exitGAP := true, exclude := exclude));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
