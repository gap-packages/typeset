#############################################################################
##
#M  TypesetStructureDescription( <structure description string> ) . 
##  
## converts a structure description string into a typesettable format.
##
InstallMethod(TypesetStructureDescription, "typesetting structure description strings", true,
[ IsString ], 0, 
function( desc )
    local str;
    str := Concatenation("\\rm ", LatexStructureDescription(desc), "\n");
    Print(str);
end);

#############################################################################
##
#M  LatexStructureDescription( <structure description string> ) . 
##  
## converts a structure description string into a LaTeX-renderable format.
##
InstallMethod(LatexStructureDescription, "for structure description strings", true,
[ IsString ], 0 ,
function( desc )
    local ret, sub, j, i, closed, op;

    # Handle trivial group explicitly
    if desc="1" then
        return desc;
    fi;

    # Handle possible operators {:, ., x, /, =}
    if ':' in desc then
        Info(InfoTypeset, 2, "To use \\rtimes, add the amssymb package to your premable \\usepackage{amssymb}");
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
            if not ',' in desc and not "Sz(" in desc and not "Ree(" in desc then
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
            # If parentheses are included, can return the raw description.
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
#M  ConcatStructDescOperands( <structure description string>, <separator>, <new separator> ) . 
##  
## splits and concatenates operands for binary operators within structure descriptions
## based on the provided separators.
##
InstallMethod(ConcatStructDescOperands, "for structure description operands", true,
[ IsString, IsString, IsString ], 0,
function( desc, sep, newsep )
    local sub, i, tokens, ret;

    sub := SplitString(desc, sep);
    tokens := [];
    for i in [1 .. Length(sub)] do
        tokens[i] := LatexStructureDescription(sub[i]);
    od;

    return JoinStringsWithSeparator(tokens, newsep);
end);