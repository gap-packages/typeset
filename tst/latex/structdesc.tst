gap> START_TEST( "structure descriptions of groups" );

# 'Typeset' for sample structure descriptions
gap> TypesetStructureDescription("1");
\rm 1
gap> TypesetStructureDescription("M11");
\rm M_{11}
gap> TypesetStructureDescription("C2");
\rm C_{2}
gap> TypesetStructureDescription("Fi24'");
\rm Fi_{24}'
gap> TypesetStructureDescription("Ree(3)");
\rm Ree(3)
gap> TypesetStructureDescription("O(4, 3)");
\rm O(4, 3)
gap> TypesetStructureDescription("O+(4, 3)");
\rm O^{+}(4, 3)
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
\rm \Phi(C_{2}) \cdot C_{2}/\Phi(C_{2})
gap> TypesetStructureDescription("Phi(SL(2, 4)) . SL(2, 4)/Phi(SL(2, 4))");
\rm \Phi(SL(2, 4)) \cdot SL(2, 4)/\Phi(SL(2, 4))
gap> TypesetStructureDescription("C(C2) . C2/C(C2) = C2' . C2/C2'");
\rm C(C_{2}) \cdot C_{2}/C(C_{2}) = C_{2}' \cdot C_{2}/C_{2}'
gap> TypesetStructureDescription("C(Ree(4)) . Ree(4)/C(Ree(4)) = Ree(4)' . Ree(4)/Ree(4)'");
\rm C(Ree(4)) \cdot Ree(4)/C(Ree(4)) = Ree(4)' \cdot Ree(4)/Ree(4)'
gap> STOP_TEST( "structdesc.tst" );
