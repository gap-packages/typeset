#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "latexgen",
Subtitle := "Automatic LaTeX string generation for common GAP objects",
Version := "1.0",
Date := "11/11/2022", # dd/mm/yyyy format
License := "GPL-2.0-or-later",

Persons := [
  rec(
    FirstNames := "Zachariah",
    LastName := "Newbery",
    WWWHome := "https://zachnewbery.com",
    Email := "zn6@st-andrews.ac.uk",
    IsAuthor := true,
    IsMaintainer := true,
    #PostalAddress := TODO,
    Place := "St. Andrews",
    Institution := "University of St. Andrews",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/ZachNewbery/latexgen",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://ZachNewbery.github.io/latexgen/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "latexgen",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Automatic LaTeX string generation for common GAP objects",
),

Dependencies := rec(
  GAP := ">= 4.11",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [["digraphs", ">=1.5.0"],],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [ "latex", "typesetting", "markdown" ],

));


