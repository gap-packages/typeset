gap> START_TEST( "structure descriptions of groups" );

# 'Typeset' for sample structure descriptions
gap> TypesetStructureDescription("C2");
\rm C_{2}
gap> TypesetStructureDescription("C5 : C4");
\rm C_{5} \rtimes C_{4}
gap> TypesetStructureDescription("SL(2, 3)");
\rm SL(2, 3)
gap> TypesetStructureDescription("C2 x C2 x S3");
\rm C_{2} \times C_{2} \times S_{3}
gap> TypesetStructureDescription("C2 x (C3 : C4)");
\rm C_{2} \times (C_{3} \rtimes C_{4})
gap> TypesetStructureDescription("C2 x ((C6 x C2) : C2)");
\rm C_{2} \times ((C_{6} \times C_{2}) \rtimes C_{2})
gap> TypesetStructureDescription("Phi(C2) . C2/Phi(C2)");
\rm Phi(C_{2}) \cdot C_{2}/Phi(C_{2})
gap> TypesetStructureDescription("C(C2) . C2/C(C2) = C2' . C2/C2'");
\rm C(C_{2}) \cdot C_{2}/C(C_{2}) = C_{2}' \cdot C_{2}/C_{2}'
gap> STOP_TEST( "structdesc.tst" );