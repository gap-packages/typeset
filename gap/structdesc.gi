InstallMethod(LatexStructureDescription, "for structure description strings", true,
[ IsString ], 0 ,
function( desc )
    local ret, sub, i, closed;
    # Handle possible operators
    if ':' in desc then
        return ConcatStructDescOperands(desc, ':', " : ");
    elif '.' in desc then
        desc := ReplacedString(desc, "Phi", "\\Phi");
        return ConcatStructDescOperands(desc, '.', " \\cdot ");
    elif 'x' in desc then
        return ConcatStructDescOperands(desc, 'x', " \\times ");
    elif '/' in desc then
        return ConcatStructDescOperands(desc, '/', " / ");
    elif '=' in desc then
        return ConcatStructDescOperands(desc, '=', " = ");
    else
        if '(' in desc and ')' in desc then
            return desc;
        else
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

InstallMethod(ConcatStructDescOperands, "for structure description operands", true,
[ IsString, IsChar, IsString ], 0,
function( desc, sep, newsep )
    local sub, i, tokens;

    sub := SplitString(desc, sep);
    tokens := [];
    for i in [1 .. Length(sub)] do
        tokens[i] := LatexStructureDescription(sub[i]);
    od;

    return JoinStringsWithSeparator(tokens, newsep);
end);