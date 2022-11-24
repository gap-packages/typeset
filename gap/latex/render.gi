
InstallValue(DefaultLaTeXPreamble,
"\\documentclass[12pt]{article}\n\\usepackage[english]{babel}\n\\usepackage{amsmath}\n\\usepackage{amssymb}\n\\usepackage{dot2texi}\n\\usepackage[x11names, svgnames, rgb]{xcolor}\n\\usepackage[utf8]{inputenc}\n\\usepackage{tikz}\n\\usetikzlibrary{snakes,arrows,shapes}\n\\begin{document}\n\\pagestyle{empty}\n"
);

InstallValue(DefaultMathJaxTags,
"<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"utf-8\">\n<meta name=\"viewport\" content=\"width=device-width\">\n<title>MathJax Output</title>\n<script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>\n<script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"https://tikzjax.com/v1/fonts.css\">\n<script src=\"https://tikzjax.com/v1/tikzjax.js\"></script>\n</head>"
);

InstallValue(AlwaysUnescapedChars,
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-.~"
);

#############################################################################
##
#M  RenderLatex( <string> ) . 
##  
## renders a given string in a LaTeX environment.
##
InstallMethod(RenderLatex, "for all LaTeX strings", true,
[ IsString ], 0,
function( str )
    local render;
    if ValueOption("output")<>fail then
        render := ValueOption("output");
        if render="pdflatex" then
            PDFLatex(str);
        elif render="overleaf" then
            Overleaf(str);
        else
            MathJax(str);
        fi;
    else
        # Default to rendering with MathJax HTML.
        MathJax(str);
    fi;
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
    local dir, f, out;

    dir := DirectoryTemporary();
    f := Filename(dir, "out.tex");
    out := OutputTextFile(f, true);
    SetPrintFormattingStatus(out, false);

    PrintTo(out, DefaultLaTeXPreamble);
    if not StartsWith(str, "\\begin{center}\n\\begin{tikzpicture}") then
        str := Concatenation("$", str, "$");
    fi;
    AppendTo(out, str);
    AppendTo(out, "\n\\end{document}");

    Exec(Concatenation("cd ", Filename(dir, ""), ";", "pdflatex out.tex"));

    OpenExternal(Filename(dir, "out.pdf"));
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
    local dir, f, out;
    dir := DirectoryTemporary();
    f := Filename(dir, "out.html");
    out := OutputTextFile(f, true);
    SetPrintFormattingStatus(out, false);

    PrintTo(out, DefaultMathJaxTags);
    AppendTo(out, "<body><p>");
    if StartsWith(str, "\\begin{center}\n\\begin{tikzpicture}") then
        if StartsWith(str{[63..Length(str) - 1]}, "\\begin{dot2tex}") then
            # Throw Error
			Error("Importing LaTeX packages is not implemented in MathJax and required for dot2texi, please try a different rendering method.");
            return;
        else
            str := ReplacedString(str{[16..Length(str)-13]}, ">=latex',", "");
            str := Concatenation("\n<script type=\"text/tikz\">\n", str, "</script>");
        fi;
    else
        str := Concatenation("\\[\n", str, "\\]");
    fi;

    AppendTo(out, str);
    AppendTo(out, "\n</p></body>");

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

    if not StartsWith(str, "\\begin{center}\n\\begin{tikzpicture}") then
        str := Concatenation("$", str, "$");
    fi;

    str := Concatenation(DefaultLaTeXPreamble, str, "\n\\end{document}");

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
    local uriComp, old, new, i;
    uriComp := "";

    for i in [1..Length(raw)] do
        if raw[i] in AlwaysUnescapedChars then
            Add(uriComp, raw[i]);
        else
            new := HexStringInt(IntChar(raw[i]));
            if Length(new) = 1 then
                # HexStringInt does not return leading zeroes,
                # so need to manually add them.
                new := Concatenation("0", new);
            fi;

            new := Concatenation("%", new);
            Append(uriComp, new);
        fi;
    od;

    return uriComp;
end);