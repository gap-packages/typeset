#@local c
gap> START_TEST( "ctbl.tst" );

# 'Typeset' for Character Table of Cyclic Group of Order 10.
gap> c := CharacterTable("Cyclic", 10);;
gap> Typeset(c);
% For including legends, make sure to include the amsmath package in your preamble (\usepackage{amsmath})
\begin{tabular}{c c c c c c c c c c c}
 & 1a & 10a & 5a & 10b & 5b & 2a & 5c & 10c & 5d & 10d\\
X.1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 \\
X.2 & 1 & A & B & -\bar{B} & -\bar{A} & -1 & -A & -B & \bar{B} & \bar{A} \\
X.3 & 1 & B & -\bar{A} & -A & \bar{B} & 1 & B & -\bar{A} & -A & \bar{B} \\
X.4 & 1 & -\bar{B} & -A & \bar{A} & B & -1 & \bar{B} & A & -\bar{A} & -B \\
X.5 & 1 & -\bar{A} & \bar{B} & B & -A & 1 & -\bar{A} & \bar{B} & B & -A \\
X.6 & 1 & -1 & 1 & -1 & 1 & -1 & 1 & -1 & 1 & -1 \\
X.7 & 1 & -A & B & \bar{B} & -\bar{A} & 1 & -A & B & \bar{B} & -\bar{A} \\
X.8 & 1 & -B & -\bar{A} & A & \bar{B} & -1 & B & \bar{A} & -A & -\bar{B} \\
X.9 & 1 & \bar{B} & -A & -\bar{A} & B & 1 & \bar{B} & -A & -\bar{A} & B \\
X.10 & 1 & \bar{A} & \bar{B} & -B & -A & -1 & -\bar{A} & -\bar{B} & B & A \\
\end{tabular}
\begin{align*}
A=-E(5)^3\\
B=E(5)\end{align*}
gap> STOP_TEST( "ctbl.tst" );