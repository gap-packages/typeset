#
# typeset: Automatic typesetting framework for common GAP objects, with LaTeX generation
#
# This file is a script which compiles the package manual.
#
if fail = LoadPackage("AutoDoc") then
    Error("AutoDoc required.");
fi;

AutoDoc("typeset", rec( scaffold := true, autodoc := rec( scan_dirs := [ ".", "gap", "lib", "examples", "examples/doc", "gap/latex", "gap/mathml" ] )));
