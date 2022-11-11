#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc") then
    Error("AutoDoc required.");
fi;

AutoDoc("latexgen", rec( scaffold := true, autodoc := true ));
