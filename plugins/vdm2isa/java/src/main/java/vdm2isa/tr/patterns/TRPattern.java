package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.patterns.TCIdentifierPattern;
import com.fujitsu.vdmj.tc.statements.TCIdentifierDesignator;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;

public class TRPattern extends TRNode {
    
    private final String pattern; 

    public TRPattern(TCIdentifierPattern owner)
    {
        super(owner.location);
        pattern = owner.toString();
    }

    public TRPatternList getPatternList()
    {
        TRPatternList list = new TRPatternList();
        list.add(this);
        return list; 
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return pattern;
    }
}
