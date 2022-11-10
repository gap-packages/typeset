#
# latexgen: Automatic LaTeX string generation for common GAP objects
#
#! @Chapter Rendering LaTeX Strings
#!
#! latexgen is a package that implements an operation Typeset that can
#! generate LaTeX string representations of a commonly used subset
#! of mathematical objects within the GAP system.
#!
#! Typeset is also built to be incredibly extensible, and can be easily
#! extended to also support the generation of strings for other mark-up
#! languages.
#!
#! @Section Methods

#! @Description
#!   RenderLatex renders a given LaTeX string in a LaTeX environment,
#!   providing a visual example of what the string would look like
#!   in a paper.
DeclareOperation("RenderLatex", [ IsString ]);