#@local x, y, f, b, g
gap> START_TEST( "polynomial Latex string generation ");

# Trivial single variable polynomial
gap> x := Indeterminate(Rationals, 1);;
gap> f := x + x^2 - 12 + 7 * x ^ 3;;
gap> Typeset(f);
7x_{1}^{3}+x_{1}^{2}+x_{1}-12

# Multi-variable polynomial
gap> y := Indeterminate(Rationals, 2);;
gap> f := 3 + x^2 * y + y ^ 5 + x;;
gap> Typeset(f);
x_{2}^{5}+x_{1}^{2}x_{2}+x_{1}+3

# Cyclotomic polynomial
gap> f := CyclotomicPolynomial( GF(2), 7 );;
gap> Typeset(f);
x_{1}^{6}+x_{1}^{5}+x_{1}^{4}+x_{1}^{3}+x_{1}^{2}+x_{1}+Z(2)^{0}

# Polynomial operations
gap> f := 3+x*y+x^5;; g := 5+x^2*y+x*y^2;;
gap> b := (g*f);;
gap> Typeset(b);
x_{1}^{7}x_{2}+x_{1}^{6}x_{2}^{2}+5x_{1}^{5}+x_{1}^{3}x_{2}^{2}+x_{1}^{2}x_{2}\
^{3}+3x_{1}^{2}x_{2}+3x_{1}x_{2}^{2}+5x_{1}x_{2}+15

# End test
gap> STOP_TEST( "polynomials.tst" );