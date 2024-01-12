#@local x, y, z, i, p
gap> START_TEST( "simple type LaTeX generation" );

# Rationals
gap> y := 5;;
gap> Typeset(y);
5
gap> y := 3/4;;
gap> Typeset(y);
\frac{3}{4}

# Infinity
gap> i := infinity;;
gap> Typeset(i);
\infty
gap> i := -infinity;;
gap> Typeset(i);
-\infty

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

# Permutations
gap> p := (1, 2, 3);;
gap> Typeset(p);
\left(1,2,3\right)
gap> p := (1, 2, 3)(4, 5);;
gap> Typeset(p);
\left(1,2,3\right)\left(4,5\right)
gap> p := ();;
gap> Typeset(p);
\left(\right)

# Floats
gap> x := 3.14;; Typeset(x);
3.14
gap> x := 6.62607e-34;; Typeset(x);
6.62607e-34
gap> x := 3.4/5.9;; Typeset(x);
0.576271

# Lists
gap> x := [1];;
gap> Typeset(x);
[1]
gap> x := [1, 2];;
gap> Typeset(x);
[1,2]
gap> x := [1, 1/3, (1, 2)];;
gap> Typeset(x);
[1,\frac{1}{3},\left(1,2\right)]
gap> x := [];;
gap> Typeset(x);
[]

# Matrix of Rationals
gap> x := [[0, 1], [1, 0]];;
gap> Typeset(x);
\left(\begin{array}{rr}
0 & 1 \\
1 & 0 \\
\end{array}\right)

# Matrix with alternate delimiters
gap> Typeset(x : RDelim:="]", LDelim:="[");
\left[\begin{array}{rr}
0 & 1 \\
1 & 0 \\
\end{array}\right]

# Matrix with angled bracket delimiters
gap> Typeset(x : RDelim:=">", LDelim:="<");
\left\langle\begin{array}{rr}
0 & 1 \\
1 & 0 \\
\end{array}\right\rangle

# Matrix with mix of rationals
gap> x := [[0, 1/3], [1, 3/4]];;
gap> Typeset(x);
\left(\begin{array}{rr}
0 & \frac{1}{3} \\
1 & \frac{3}{4} \\
\end{array}\right)

# Matrix with FFEs
gap> x := [ [ Z(3)^0, Z(3)^0,   Z(3) ],
>            [   Z(3), 0*Z(3),   Z(3) ],
>            [ 0*Z(3),   Z(3), 0*Z(3) ] ];;
gap> Typeset(x);
\left(\begin{array}{rrr}
Z(3)^{0} & Z(3)^{0} & Z(3) \\
Z(3) & 0 \times Z(3) & Z(3) \\
0 \times Z(3) & Z(3) & 0 \times Z(3) \\
\end{array}\right)

# Nested Lists and Matrices
gap> x := [[[1]]];;
gap> Typeset(x:MatAsList:=false);
[\left(\begin{array}{r}
1 \\
\end{array}\right)]
gap> Typeset(x:MatAsList:=true);
[[[1]]]
gap> x := [[[(1, 2)], [1]], [1/7]];;
gap> Typeset(x);
[[[\left(1,2\right)],[1]],[\frac{1}{7}]]
gap> x := [[[(1, 2)]]];;
gap> Typeset(x:MatAsList:=true);
[[[\left(1,2\right)]]]
gap> x := [[[0], [1]], [1/7]];;
gap> Typeset(x);
[\left(\begin{array}{r}
0 \\
1 \\
\end{array}\right),[\frac{1}{7}]]

# End Test
gap> STOP_TEST( "typeset.tst" );
