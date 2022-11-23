#@local g, g2
gap> START_TEST( "digraph integration" );

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
  \node (1) at (9.0bp,64.11bp) [draw,circle] {1};
  \node (2) at (9.0bp,10.11bp) [draw,circle] {2};
  \draw [->] (1) ..controls (24.793bp,77.009bp) and (36.0bp,74.762bp)  .. (36.0bp,64.11bp) .. controls (36.0bp,57.619bp) and (31.838bp,54.249bp)  .. (1);
  \draw [->] (1) ..controls (2.4286bp,49.498bp) and (1.8464bp,38.71bp)  .. (2);
  \draw [->] (2) ..controls (15.596bp,24.954bp) and (16.157bp,35.763bp)  .. (1);
  \draw [->] (2) ..controls (24.793bp,23.009bp) and (36.0bp,20.762bp)  .. (36.0bp,10.11bp) .. controls (36.0bp,3.6189bp) and (31.838bp,0.24881bp)  .. (2);
\end{tikzpicture}
\end{center}

# End Test
gap> STOP_TEST( "digraphs.tst" );