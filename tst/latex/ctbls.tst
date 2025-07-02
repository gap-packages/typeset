#@local c
gap> START_TEST( "ctbl.tst" );

# Small Cyclic Group
gap> c := CharacterTable(CyclicGroup(3));;
gap> Typeset(c);
\begin{gather*}
\begin{array}{c c c c}
 & 1a & 3a & 3b \\
X.1 & 1 & 1 & 1 \\
X.2 & 1 & A & \bar{A} \\
X.3 & 1 & \bar{A} & A \\
\end{array}\\
\begin{aligned}
A &= E(3) \\
 &= (-1+Sqrt(-3))/2 = b3 \\
\end{aligned}
\end{gather*}

# Symmetric Group (without legend)
gap> c := CharacterTable(SymmetricGroup(4));;
gap> Typeset(c);
\begin{gather*}
\begin{array}{c c c c c c}
 & 1a & 2a & 2b & 3a & 4a \\
X.1 & 1 & -1 & 1 & 1 & -1 \\
X.2 & 3 & -1 & -1 & . & 1 \\
X.3 & 2 & . & 2 & -1 & . \\
X.4 & 3 & 1 & -1 & . & -1 \\
X.5 & 1 & 1 & 1 & 1 & 1 \\
\end{array}
\end{gather*}

# SL Group
gap> c := CharacterTable(SL(2, 5));;
gap> Typeset(c);
\begin{gather*}
\begin{array}{c c c c c c c c c c}
 & 1a & 10a & 10b & 2a & 5a & 5b & 3a & 6a & 4a \\
X.1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 & 1 \\
X.2 & 2 & A & *A & -2 & -A & -*A & -1 & 1 & . \\
X.3 & 2 & *A & A & -2 & -*A & -A & -1 & 1 & . \\
X.4 & 3 & *A & A & 3 & *A & A & . & . & -1 \\
X.5 & 3 & A & *A & 3 & A & *A & . & . & -1 \\
X.6 & 4 & -1 & -1 & 4 & -1 & -1 & 1 & 1 & . \\
X.7 & 4 & 1 & 1 & -4 & -1 & -1 & 1 & -1 & . \\
X.8 & 5 & . & . & 5 & . & . & -1 & -1 & 1 \\
X.9 & 6 & -1 & -1 & -6 & 1 & 1 & . & . & . \\
\end{array}\\
\begin{aligned}
A &= -E(5)-E(5)^4 \\
 &= (1-Sqrt(5))/2 = -b5 \\
\end{aligned}
\end{gather*}

# 'Typeset' for Character Table of Cyclic Group of Order 10.
gap> c := CharacterTable("Cyclic", 10);;
gap> Typeset(c);
\begin{gather*}
\begin{array}{c c c c c c c c c c c}
 & 1a & 10a & 5a & 10b & 5b & 2a & 5c & 10c & 5d & 10d \\
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
\end{array}\\
\begin{aligned}
A &= -E(5)^3 \\
B &= E(5) \\
\end{aligned}
\end{gather*}
gap> STOP_TEST( "ctbls.tst" );
