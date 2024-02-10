#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
# This file runs package tests. It is also referenced in the package
# metadata in PackageInfo.g.
#
LoadPackage( "ctbllib" );
LoadPackage( "digraphs" );

LoadPackage( "typeset" );

SetInfoLevel(InfoTypeset, 0);

# LaTeX Generation Tests
TestDirectory(DirectoriesPackageLibrary( "typeset", "tst" ),
  rec(exitGAP := true));

FORCE_QUIT_GAP(1); # if we ever get here, there was an error
