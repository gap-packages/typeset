#############################################################################
##
#M  RenderLatex( <string> ) . 
##  
## renders a given string in a LaTeX environment.
##
InstallMethod(RenderLatex, "for all LaTeX strings", true,
[ IsString ], 0,
function( str )
    # Default to rendering with MathJax HTML.
    MathJax(str);
end);

#############################################################################
##
#M  MathJax( <string> ) . 
##  
## renders a given LaTeX string in a HTML file using the MathJax library.
##
InstallMethod(MathJax, "for all LaTeX strings renderable by MathJax", true,
[ IsString ], 0,
function( str )
    local dir, f;

    dir := DirectoryTemporary();
    f := Filename(dir, "out.html");

    PrintTo(f, "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"utf-8\">\n<meta name=\"viewport\" content=\"width=device-width\">\n<title>MathJax Output</title>\n<script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>\n<script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>\n</head>");
    AppendTo(f, "<body><p>");
    AppendTo(f, "\\begin{equation}\n");
    AppendTo(f, str);
    AppendTo(f, "\\end{equation}\n</p></body>");

    OpenExternal(f);
end);