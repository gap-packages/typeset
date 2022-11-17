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
#M  PDFLatex( <string> ) . 
##  
## renders a given LaTeX string in a PDF file using the pdflatex bash command.
##
InstallMethod(PDFLatex, "for all LaTeX strings renderable by pdflatex", true,
[ IsString ], 0,
function ( str )
    local url;

    url := "https://www.overleaf.com/docs?snip=";
    Append(url, URIEncodeComponent(str));

    OpenExternal(url);
end);

#############################################################################
##
#M  MathJax( <string> ) . 
##  
## renders a given LaTeX string in a HTML file using the MathJax library.
##
InstallMethod(MathJax, "for all LaTeX strings renderable by MathJax", true,
[ IsString ], 0,
function ( str )
    local dir, f;

    dir := DirectoryTemporary();
    f := Filename(dir, "out.html");

    PrintTo(f, "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"utf-8\">\n<meta name=\"viewport\" content=\"width=device-width\">\n<title>MathJax Output</title>\n<script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>\n<script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>\n</head>");
    AppendTo(f, "<body><p>");


    AppendTo(f, "\\[\n");
    AppendTo(f, str);
    AppendTo(f, "\\]\n</p></body>");

    OpenExternal(f);
end);

#############################################################################
##
#M  Overleaf( <string> ) . 
##  
## renders a given LaTeX string in a HTML file using the Overleaf API.
##
InstallMethod(Overleaf, "for all LaTeX strings renderable by Overleaf", true,
[ IsString ], 0,
function ( str )
    local url;

    url := "https://www.overleaf.com/docs?snip=";
    Append(url, URIEncodeComponent(str));

    OpenExternal(url);
end);

#############################################################################
##
#M  URIEncodeComponent( <string> ) . 
##  
## replaces reserved characters in a URI component according to RFC-3986.
##
InstallMethod(URIEncodeComponent, "to encode URLS to avoid unprocessable characters", true,
[ IsString ], 0,
function ( raw )
    local uriComp, old, new, i, alwaysUnescaped;
    alwaysUnescaped := "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-.~\n";
    uriComp := "%24"; # Add dollar sign to indicate math mode.

    for i in [1..Length(raw)] do
        if raw[i] in alwaysUnescaped then
            Add(uriComp, raw[i]);
        else
            new := Concatenation("%", HexStringInt(IntChar(raw[i])));
            Append(uriComp, new);
        fi;
    od;

    # HexStringInt returns %A0 rather than %0A for new-line characters...
    uriComp := ReplacedString(uriComp, "\n", "%0A");
    Append(uriComp, "%24");

    return uriComp;
end);