#############################################################################
##
#F  TypesetStructureDescription( <structure description string> ) . 
##  
## converts a structure description string into a typesettable format.
##
InstallGlobalFunction(TypesetStructureDescription,
function( desc )
    local str;
    str := Concatenation("\\rm ", LatexStructureDescription(desc), "\n");
    Print(str);
end);

#############################################################################
##
#F  LatexStructureDescription( <structure description string> ) . 
##  
## converts a structure description string into a LaTeX-renderable format.
##
InstallGlobalFunction(LatexStructureDescription,
function( desc )
    local ret, sub, j, i, closed, op;

    # Handle trivial group explicitly
    if desc="1" then
        return desc;
    fi;

    # Handle possible operators {:, ., x, /, =}
    if ':' in desc then
        Info(InfoTypeset, 2, "To use the rtimes LaTeX command, add the amssymb package to your premable \\usepackage{amssymb}");
        return ConcatStructDescOperands(desc, ":", "\\rtimes");
    elif '.' in desc then
        return ConcatStructDescOperands(desc, ".", "\\cdot");
    elif 'x' in desc then
        return ConcatStructDescOperands(desc, "x", "\\times");
    elif '/' in desc then
        return ConcatStructDescOperands(desc, "/", "/");
    elif '=' in desc then
        return ConcatStructDescOperands(desc, "=", "=");
    else
        if '(' in desc and ')' in desc then
            if PositionSublist(desc, "C(")<>fail or PositionSublist(desc, "Phi(")<>fail then
                # Structure descriptions of the form C(G) or Phi(G)
                ret := "";

                # Ignore preceding open parentheses
                j := 1;
                while desc[j]='(' do
                    j := j + 1;
                    Add(ret, '(');
                od;

                # Recurse on nested operand
                if StartsWith(desc{[j..Length(desc)]}, "C(") then
                    op := LatexStructureDescription(desc{[j+2..Length(desc)]});
                    return Concatenation(ret, "C(", op);
                else
                    op := LatexStructureDescription(desc{[j+4..Length(desc)]});
                    return Concatenation(ret, "\\Phi(", op);
                fi;
            fi;

            if 'O' in desc then
                # Orthogonal group, need to super-script + and -
                desc := ReplacedString(ReplacedString(desc, "O+", "O^{+}"), "O-", "O^{-}");
            fi;

            # All other groups with parentheses don't need any extra processing
            return desc;
        else
            # Generic structure descriptions
            ret := "";
            closed := false;
            for i in [Length(desc), Length(desc) - 1..1] do
                if IsAlphaChar(desc[i]) then
                    if closed then
                        Add(ret, '{', 1);
                        Add(ret, '_', 1);
                    fi;
                    ret := Concatenation(desc{[1..i]}, ret);
                    break;
                elif IsDigitChar(desc[i]) and not closed then
                    Add(ret, '}', 1);
                    closed := true;
                fi;
                Add(ret, desc[i], 1);
            od;
            return ret;
        fi;
    fi;
end);

#############################################################################
##
#F  ConcatStructDescOperands( <structure description string>, <separator>, <new separator> ) . 
##  
## splits and concatenates operands for binary operators within structure descriptions
## based on the provided separators.
##
InstallGlobalFunction(ConcatStructDescOperands,
function( desc, sep, newsep )
    local sub, i, tokens, ret;

    sub := SplitString(desc, sep);
    tokens := [];
    for i in [1 .. Length(sub)] do
        tokens[i] := LatexStructureDescription(sub[i]);
    od;

    return JoinStringsWithSeparator(tokens, newsep);
end);
