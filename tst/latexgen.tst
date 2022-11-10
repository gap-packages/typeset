#@local x, y, z
gap> START_TEST( "arbitrary identifier string" );

# Rationals
gap> y := 5;;
gap> Typeset(y);
5
gap> y := 3/4;;
gap> Typeset(y);
\frac{3}{4}

# Finite Field Elements
gap> z := Z(3);;
gap> Typeset(z);
Z(3)
gap> z := Z(2^3);;
gap> Typeset(z);
Z(2^{3})
gap> z := Z(2^3)^5;;
gap> Typeset(z);
Z(2^{3})^{5}
gap> z := Z(5)^3;;
gap> Typeset(z);
Z(5)^{3}

# Matrix of Rationals
gap> x := [[0, 1], [1, 0]];;
gap> Typeset(x);
\left(\begin{array}{rr}
0 & 1 \\
1 & 0 \\
\end{array}\right)

# Matrix with FFEs
gap> x := [ [ Z(3)^0, Z(3)^0,   Z(3) ],
>            [   Z(3), 0*Z(3),   Z(3) ],
>            [ 0*Z(3),   Z(3), 0*Z(3) ] ];;
gap> Typeset(x);
\left(\begin{array}{rrr}
Z(3)^{0} & Z(3)^{0} & Z(3) \\
Z(3) & 0*Z(3) & Z(3) \\
0*Z(3) & Z(3) & 0*Z(3) \\
\end{array}\right)

# End Test
gap> STOP_TEST( "latexgen.tst" );
