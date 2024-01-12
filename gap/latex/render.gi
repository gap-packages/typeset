#############################################################################
##
#F  RenderLatex( <string> ) . 
##  
## renders a given string in a LaTeX environment.
##
InstallGlobalFunction(RenderLatex,
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
#F  PDFLatex( <string> ) . 
##  
## renders a given LaTeX string in a PDF file using the pdflatex bash command.
##
InstallGlobalFunction(PDFLatex,
function ( str )
    local dir, f, out;

    Info(InfoTypeset, 3, "Creating temporary .tex file");
    dir := DirectoryTemporary();
    f := Filename(dir, "out.tex");
    out := OutputTextFile(f, true);
    SetPrintFormattingStatus(out, false);

    PrintTo(out, DEFAULT_LATEX_PREAMBLE);
    if NeedsLatexMathMode(str) then
        str := Concatenation("$", str, "$");
    fi;
    AppendTo(out, str);
    AppendTo(out, "\n\\end{document}");
    Info(InfoTypeset, 3, "Successfully created .tex file for compilation");

    Info(InfoTypeset, 3, "Running pdflatex on created .tex file");
    Exec(Concatenation("cd ", Filename(dir, ""), ";", "pdflatex --shell-escape out.tex"));

    OpenExternal(Filename(dir, "out.pdf"));
end);

#############################################################################
##
#F  MathJax( <string> ) . 
##  
## renders a given LaTeX string in a HTML file using the MathJax library.
##
InstallGlobalFunction(MathJax,
function ( str )
    local dir, f, out;

    Info(InfoTypeset, 3, "Creating temporary .html file");
    dir := DirectoryTemporary();
    f := Filename(dir, "out.html");
    out := OutputTextFile(f, true);
    SetPrintFormattingStatus(out, false);

    PrintTo(out, DEFAULT_MATHJAX_TAGS);
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
    Info(InfoTypeset, 3, "Successfully created .html file for viewing");

    OpenExternal(f);
end);

#############################################################################
##
#F  Overleaf( <string> ) . 
##  
## renders a given LaTeX string in a HTML file using the Overleaf API.
##
InstallGlobalFunction(Overleaf,
function ( str )
    local url;
    if NeedsLatexMathMode(str) then
        # Assume all non-tikz strings are to be processed in math mode.
        str := Concatenation("$", str, "$");
    fi;

    str := Concatenation(DEFAULT_LATEX_PREAMBLE, str, "\n\\end{document}");

    url := "https://www.overleaf.com/docs?snip=";
    Append(url, URIEncodeComponent(str));
    Info(InfoTypeset, 3, "Successfully created URL for Overleaf, navigating there now");

    OpenExternal(url);
end);

#############################################################################
##
#F  URIEncodeComponent( <string> ) . 
##  
## replaces reserved characters in a URI component according to RFC-3986.
##
InstallGlobalFunction(URIEncodeComponent,
function ( raw )
    local uriComp, old, new, i;
    uriComp := "";

    for i in [1..Length(raw)] do
        if raw[i] in ALWAYS_UNESCAPED_CHARS then
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

#############################################################################
##
#F  NeedsLatexMathMode( <string> ) . 
##  
## returns true if the provided snippet needs to be rendered in math mode.
##
InstallGlobalFunction(NeedsLatexMathMode,
function ( raw )
    return not (StartsWith(raw, "\\begin{center}\n\\begin{tikzpicture}") or StartsWith(raw, "\\begin{gather*}"));
end);

#############################################################################
##
#V  DEFAULT_LATEX_PREAMBLE . 
##  
## 	Default Preamble for a .tex document to load all of the possible packages
##  that may be required by a generated LaTeX snippet by this package.
##
InstallValue(DEFAULT_LATEX_PREAMBLE,
    Concatenation(["\\documentclass[12pt]{article}\n",
    "\\usepackage[english]{babel}\n",
    "\\usepackage{amsmath}\n",
    "\\usepackage{amssymb}\n",
    "\\usepackage{dot2texi}\n",
    "\\usepackage[x11names, svgnames, rgb]{xcolor}\n",
    "\\usepackage[utf8]{inputenc}\n",
    "\\usepackage{tikz}\n",
    "\\usetikzlibrary{decorations,arrows,shapes}\n",
    "\\begin{document}\n",
    "\\pagestyle{empty}\n"])
);

#############################################################################
##
#V  DEFAULT_MATHJAX_TAGS . 
##  
## 	Default HTML document and head tags used to render MathJax snippets.
##
InstallValue(DEFAULT_MATHJAX_TAGS,
    Concatenation(["<!DOCTYPE html>\n",
    "<html>\n",
    "<head>\n",
    "<meta charset=\"utf-8\">\n",
    "<meta name=\"viewport\" content=\"width=device-width\">\n",
    "<title>MathJax Output</title>\n",
    "<script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>\n",
    "<script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>\n",
    "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://tikzjax.com/v1/fonts.css\">\n",
    "<script src=\"https://tikzjax.com/v1/tikzjax.js\"></script>\n",
    "</head>"])
);

#############################################################################
##
#V  ALWAYS_UNESCAPED_CHARS . 
##  
## 	String containing all of the characters that do not need to be percent
##  encoded within URI components as per RFC-3986.
##
InstallValue(ALWAYS_UNESCAPED_CHARS,
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-.~"
);
