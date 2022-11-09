gap> START_TEST( "polynomial Latex string generation ");

# Trivial single variable polynomial
gap> x := Indeterminate(Rationals, 1);;
gap> f := x + x^2 - 12 + 7 * x ^ 3;;
gap> Typeset(f);
7x_{1}^{3}+x_{1}^{2}+x_{1}-12
gap> y := Indeterminate(Rationals, 2);;
gap> g := 3 + x^2 * y + y ^ 5 + x;;
gap> Typeset(g);
x_{2}^{5}+x_{1}^{2}x_{2}+x_{1}+3
gap> STOP_TEST( "polynomials.tst" );