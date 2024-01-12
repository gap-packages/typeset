#@local x, y, f, b, g, m
gap> START_TEST( "polynomial LaTeX string generation ");

# Trivial single variable polynomial
gap> x := Indeterminate(Rationals, 1);;
gap> f := x + x^2 - 12 + 7 * x ^ 3;;
gap> Typeset(f);
7x_{1}^{3}+x_{1}^{2}+x_{1}-12
gap> f := -x^7;;
gap> Typeset(f);
-x_{1}^{7}

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
x_{1}^{7}x_{2}+x_{1}^{6}x_{2}^{2}+5x_{1}^{5}+x_{1}^{3}x_{2}^{2}+x_{1}^{2}x_{2}^{3}+3x_{1}^{2}x_{2}+3x_{1}x_{2}^{2}+5x_{1}x_{2}+15

# Non-Polynomial Rational Functions
gap> b:=(g)/(f^2);;
gap> Typeset(b);
\frac{x_{1}^{2}x_{2}+x_{1}x_{2}^{2}+5}{x_{1}^{10}+2x_{1}^{6}x_{2}+6x_{1}^{5}+x_{1}^{2}x_{2}^{2}+6x_{1}x_{2}+9}

# Matrix of polynomials
gap> m := [[g, f], [f^2, f]];;
gap> Typeset(m);
\left(\begin{array}{rr}
x_{1}^{2}x_{2}+x_{1}x_{2}^{2}+5 & x_{1}^{5}+x_{1}x_{2}+3 \\
x_{1}^{10}+2x_{1}^{6}x_{2}+6x_{1}^{5}+x_{1}^{2}x_{2}^{2}+6x_{1}x_{2}+9 & x_{1}^{5}+x_{1}x_{2}+3 \\
\end{array}\right)

# End test
gap> STOP_TEST( "polynomials.tst" );
