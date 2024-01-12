#@local x, y, z, i, p
gap> START_TEST( "simple type MathML generation" );

# Rationals
gap> y := 5;;
gap> Typeset(y : Lang:="mathml");
<mn>5</mn>
gap> y := 3/4;;
gap> Typeset(y : Lang:="mathml");
<mfrac><mn>3</mn><mn>4</mn></mfrac>

# Infinity
gap> i := infinity;;
gap> Typeset(i : Lang:="mathml");
<infinity/>
gap> i := -infinity;;
gap> Typeset(i : Lang:="mathml");
-<infinity/>

# Lists
gap> x := [1];;
gap> Typeset(x : Lang:="mathml");
<mo>(</mo><mn>1</mn><mo>)</mo>
gap> x := [1, 2];;
gap> Typeset(x : Lang:="mathml");
<mo>(</mo><mn>1</mn><mo>,&nbsp;</mo><mn>2</mn><mo>)</mo>
gap> x := [1, 1/3];;
gap> Typeset(x : Lang:="mathml");
<mo>(</mo><mn>1</mn><mo>,&nbsp;</mo><mfrac><mn>1</mn><mn>3</mn></mfrac><mo>)</mo>
gap> x := [];;
gap> Typeset(x : Lang:="mathml");
<mo>(</mo><mo>)</mo>

# Matrix of Rationals
gap> x := [[0, 1], [1, 0]];;
gap> Typeset(x : Lang:="mathml");
<mo>(</mo><mtable><mtr><mtd><mn>0</mn></mtd><mtd><mn>1</mn></mtd></mtr><mtr><mtd><mn>1</mn></mtd><mtd><mn>0</mn></mtd></mtr></mtable><mo>)</mo>

# Matrix with alternate delimiters
gap> Typeset(x : Lang:="mathml", RDelim:="]", LDelim:="[");
<mo>[</mo><mtable><mtr><mtd><mn>0</mn></mtd><mtd><mn>1</mn></mtd></mtr><mtr><mtd><mn>1</mn></mtd><mtd><mn>0</mn></mtd></mtr></mtable><mo>]</mo>

# Matrix with mix of rationals
gap> x := [[0, 1/3], [1, 3/4]];;
gap> Typeset(x: Lang:="mathml");
<mo>(</mo><mtable><mtr><mtd><mn>0</mn></mtd><mtd><mfrac><mn>1</mn><mn>3</mn></mfrac></mtd></mtr><mtr><mtd><mn>1</mn></mtd><mtd><mfrac><mn>3</mn><mn>4</mn></mfrac></mtd></mtr></mtable><mo>)</mo>

# Matrix as list
gap> x := [[[1]]];;
gap> Typeset([[[1]]] : Lang:="mathml", MatAsList:=true);
<mo>(</mo><mo>(</mo><mo>(</mo><mn>1</mn><mo>)</mo><mo>)</mo><mo>)</mo>

# End Test
gap> STOP_TEST( "typeset.tst" );
