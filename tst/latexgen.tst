#@local x
gap> START_TEST( "arbitrary identifier string" );

# 'Typeset' for Matrix of rationals
gap> x := [[0, 1], [1, 0]];;
gap> Typeset(x);
\left(\begin{array}{rr}
'0'&'1'\\
'1'&'0'\\
\end{array}\right)
gap> STOP_TEST( "latexgen.tst" );
