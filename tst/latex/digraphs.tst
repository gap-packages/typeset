#@local g, g2
gap> START_TEST( "digraphs.tst" );

# Dot2Texi LaTeX Environment
gap> g := Digraph([[1, 2], [2, 1]]);;
gap> Typeset(g);
\begin{center}
\begin{tikzpicture}[>=latex',line join=bevel,]
\begin{dot2tex}[dot,tikz,codeonly,styleonly,options=-s -tmath]
digraph hgn{
node [shape=circle]
1
2
1 -> 1
1 -> 2
2 -> 2
2 -> 1
}
\end{dot2tex}
\end{tikzpicture}
\end{center}
gap> g2 := Digraph([[1, 2], [2, 3], [3, 4], [4, 2], [4, 1]]);;
gap> Typeset(g2);
\begin{center}
\begin{tikzpicture}[>=latex',line join=bevel,]
\begin{dot2tex}[dot,tikz,codeonly,styleonly,options=-s -tmath]
digraph hgn{
node [shape=circle]
1
2
3
4
5
1 -> 1
1 -> 2
2 -> 2
2 -> 3
3 -> 3
3 -> 4
4 -> 4
4 -> 2
5 -> 4
5 -> 1
}
\end{dot2tex}
\end{tikzpicture}
\end{center}

# Dot2Tex Command Line Invocation
gap> Typeset(g : DigraphOut:="dot2tex");
\begin{center}
\begin{tikzpicture}[>=latex',line join=bevel,]
  \node (1) at (18.0bp,90.0bp) [draw,circle] {1};
  \node (2) at (18.0bp,18.0bp) [draw,circle] {2};
  \draw [->] (1) ..controls (42.913bp,106.15bp) and (54.0bp,102.23bp)  .. (54.0bp,90.0bp) .. controls (54.0bp,82.162bp) and (49.45bp,77.737bp)  .. (1);
  \draw [->] (1) ..controls (11.327bp,64.99bp) and (11.056bp,55.461bp)  .. (2);
  \draw [->] (2) ..controls (24.668bp,42.909bp) and (24.943bp,52.433bp)  .. (1);
  \draw [->] (2) ..controls (42.913bp,34.153bp) and (54.0bp,30.234bp)  .. (54.0bp,18.0bp) .. controls (54.0bp,10.162bp) and (49.45bp,5.7374bp)  .. (2);
\end{tikzpicture}
\end{center}

# End Test
gap> STOP_TEST( "digraphs.tst" );