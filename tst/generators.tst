gap> START_TEST( "group generator notation Latex string generation ");

# Matrix Group
gap> x := Indeterminate(Rationals, 1);;
gap> f := x + x^2 - 12 + 7 * x ^ 3;;
gap> Typeset(f);
7x_{1}^{3}+x_{1}^{2}+x_{1}-12

# Permutation Group
gap> y := Indeterminate(Rationals, 2);;
gap> f := 3 + x^2 * y + y ^ 5 + x;;
gap> Typeset(f);
x_{2}^{5}+x_{1}^{2}x_{2}+x_{1}+3

# Finitely Presented Group
gap> y := Indeterminate(Rationals, 2);;
gap> f := 3 + x^2 * y + y ^ 5 + x;;
gap> Typeset(f);
x_{2}^{5}+x_{1}^{2}x_{2}+x_{1}+3

# Polycyclic Group
gap> y := Indeterminate(Rationals, 2);;
gap> f := 3 + x^2 * y + y ^ 5 + x;;
gap> Typeset(f);
x_{2}^{5}+x_{1}^{2}x_{2}+x_{1}+3

# End Test
gap> STOP_TEST( "generators.tst" );