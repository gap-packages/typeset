#@local g, G, m1, m2, f
gap> START_TEST( "group generator notation Latex string generation ");

# Permutation Groups
gap> g := Group( (3, 4) );;
gap> Typeset(g);
\langle (3,4) \rangle
gap> g := Group( (1,2)(4,5), (1,2,3)(4,5,6), (3, 4) );;
gap> Typeset(g);
\langle (1,2)(4,5),(1,2,3)(4,5,6),(3,4) \rangle

# Matrix Groups
gap> g := Group( [[0,-1],[1,0]] );;
gap> Typeset(g);
\langle \left(\begin{array}{rr}
0 & -1 \\
1 & 0 \\
\end{array}\right) \rangle
gap> m1 := [ [ Z(3)^0, Z(3)^0,   Z(3) ],
>            [   Z(3), 0*Z(3),   Z(3) ],
>            [ 0*Z(3),   Z(3), 0*Z(3) ] ];;
gap> m2 := [ [   Z(3),   Z(3), Z(3)^0 ],
>            [   Z(3), 0*Z(3),   Z(3) ],
>            [ Z(3)^0, 0*Z(3),   Z(3) ] ];;
gap> g := Group( m1, m2 );;
gap> Typeset(g);
\langle \left(\begin{array}{rrr}
Z(3)^{0} & Z(3)^{0} & Z(3) \\
Z(3) & 0*Z(3) & Z(3) \\
0*Z(3) & Z(3) & 0*Z(3) \\
\end{array}\right),\left(\begin{array}{rrr}
Z(3) & Z(3) & Z(3)^{0} \\
Z(3) & 0*Z(3) & Z(3) \\
Z(3)^{0} & 0*Z(3) & Z(3) \\
\end{array}\right) \rangle

# Finitely Presented (FP) Groups
gap> f := FreeGroup( "a", "b" );; g := f / [ f.1^5, f.2^2 ];;
gap> Typeset(g);
\langle a,b \mid a^{5},b^{2} \rangle
gap> g := f / [ f.1^5, f.2^2, (f.2 * f.1)^5 ];;
gap> Typeset(g);
\langle a,b \mid a^{5},b^{2},(b*a)^{5} \rangle
gap> g := f / [ f.1^5, f.2^2, f.1^f.2*f.1 ];;
gap> Typeset(g);
\langle a,b \mid a^{5},b^{2},b^{-1}*a*b*a \rangle

# Polycyclic (PC) Groups
gap> G := Group( (1,2,3), (3,4,1) );; g := PcGroupWithPcgs( Pcgs(G) );;
gap> Typeset(g);
\langle f1,f2,f3 \mid f1^{3},f2^{-1}*f1^{-1}*f2*f1*f3^{-1},f3^{-1}*f1^{-1}*f3*\
f1*f3^{-1}*f2^{-1},f2^{2},f3^{-1}*f2^{-1}*f3*f2,f3^{2} \rangle
gap> g := SmallGroup( 24, 12 );;
gap> Typeset(g);
\langle f1,f2,f3,f4 \mid f1^{2},f2^{-1}*f1^{-1}*f2*f1*f2^{-1},f3^{-1}*f1^{-1}*\
f3*f1*f4^{-1}*f3^{-1},f4^{-1}*f1^{-1}*f4*f1*f4^{-1}*f3^{-1},f2^{3},f3^{-1}*f2^\
{-1}*f3*f2*f4^{-1}*f3^{-1},f4^{-1}*f2^{-1}*f4*f2*f3^{-1},f3^{2},f4^{-1}*f3^{-1\
}*f4*f3,f4^{2} \rangle

# End Test
gap> STOP_TEST( "generators.tst" );