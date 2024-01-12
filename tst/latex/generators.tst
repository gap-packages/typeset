#@local g, G, m1, m2, f
gap> START_TEST( "group generator notation Latex string generation ");

# Permutation Groups
gap> g := Group( (3, 4) );;
gap> Typeset(g);
\left\langle \left(3,4\right) \right\rangle
gap> g := Group( (1,2)(4,5), (1,2,3)(4,5,6), (3, 4) );;
gap> Typeset(g);
\left\langle \left(1,2\right)\left(4,5\right),\left(1,2,3\right)\left(4,5,6\right),\left(3,4\right) \right\rangle

# Matrix Groups
gap> g := Group( [[0,-1],[1,0]] );;
gap> Typeset(g);
\left\langle \left(\begin{array}{rr}
0 & -1 \\
1 & 0 \\
\end{array}\right) \right\rangle
gap> m1 := [ [ Z(3)^0, Z(3)^0,   Z(3) ],
>            [   Z(3), 0*Z(3),   Z(3) ],
>            [ 0*Z(3),   Z(3), 0*Z(3) ] ];;
gap> m2 := [ [   Z(3),   Z(3), Z(3)^0 ],
>            [   Z(3), 0*Z(3),   Z(3) ],
>            [ Z(3)^0, 0*Z(3),   Z(3) ] ];;
gap> g := Group( m1, m2 );;
gap> Typeset(g);
\left\langle \left(\begin{array}{rrr}
Z(3)^{0} & Z(3)^{0} & Z(3) \\
Z(3) & 0 \times Z(3) & Z(3) \\
0 \times Z(3) & Z(3) & 0 \times Z(3) \\
\end{array}\right),\left(\begin{array}{rrr}
Z(3) & Z(3) & Z(3)^{0} \\
Z(3) & 0 \times Z(3) & Z(3) \\
Z(3)^{0} & 0 \times Z(3) & Z(3) \\
\end{array}\right) \right\rangle

# Finitely Presented (FP) Groups
gap> f := FreeGroup( "a", "b" );; g := f / [ f.1^5, f.2^2 ];;
gap> Typeset(g);
\left\langle a,b \mid a^{5},b^{2} \right\rangle
gap> g := f / [ f.1^5, f.2^2, (f.2 * f.1)^5 ];;
gap> Typeset(g);
\left\langle a,b \mid a^{5},b^{2},(ba)^{5} \right\rangle
gap> g := f / [ f.1^5, f.2^2, f.1^f.2*f.1 ];;
gap> Typeset(g);
\left\langle a,b \mid a^{5},b^{2},b^{-1}aba \right\rangle

# Polycyclic (PC) Groups
gap> G := Group( (1,2,3), (3,4,1) );; g := PcGroupWithPcgs( Pcgs(G) );;
gap> Typeset(g);
\left\langle f_{1},f_{2},f_{3} \mid f_{1}^{3},f_{2}^{-1}f_{1}^{-1}f_{2}f_{1}f_{3}^{-1},f_{3}^{-1}f_{1}^{-1}f_{3}f_{1}f_{3}^{-1}f_{2}^{-1},f_{2}^{2},f_{3}^{-1}f_{2}^{-1}f_{3}f_{2},f_{3}^{2} \right\rangle
gap> g := SmallGroup( 24, 12 );;
gap> Typeset(g);
\left\langle f_{1},f_{2},f_{3},f_{4} \mid f_{1}^{2},f_{2}^{-1}f_{1}^{-1}f_{2}f_{1}f_{2}^{-1},f_{3}^{-1}f_{1}^{-1}f_{3}f_{1}f_{4}^{-1}f_{3}^{-1},f_{4}^{-1}f_{1}^{-1}f_{4}f_{1}f_{4}^{-1}f_{3}^{-1},f_{2}^{3},f_{3}^{-1}f_{2}^{-1}f_{3}f_{2}f_{4}^{-1}f_{3}^{-1},f_{4}^{-1}f_{2}^{-1}f_{4}f_{2}f_{3}^{-1},f_{3}^{2},f_{4}^{-1}f_{3}^{-1}f_{4}f_{3},f_{4}^{2} \right\rangle

# End Test
gap> STOP_TEST( "generators.tst" );
