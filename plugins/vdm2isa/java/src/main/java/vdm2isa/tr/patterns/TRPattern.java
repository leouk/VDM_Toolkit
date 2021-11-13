package vdm2isa.tr.patterns;

import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.visitors.TRPatternVisitor;

public abstract class TRPattern extends TRNode {
    
    private static final long serialVersionUID = 1L;

    //private final TCPattern owner;

    public TRPattern(LexLocation location)
    {
        super(location);
        //this.owner = owner;
    }

    public TRPatternList getPatternList()
    {
        TRPatternList list = new TRPatternList();
        list.add(this);
        return list; 
    }

    @Override
    public String toString()
    {
        return super.toString() + " = " + getPattern(); // + translate();
    }

    /**
     * Transforms the translated pattern to become type aware, depending on the pattern owner type? 
     * @param pattern
     */
    protected String typeAware(String pattern)
    {
        StringBuilder sb = new StringBuilder();
        if (pattern != null)
        {
            //TODO this won't work because getPossibleType() is returning TUnknownType! :-(
            //if (owner != null && owner.getPossibleType() instanceof TCOptionalType)
            //{
            //    sb.append(IsaToken.parenthesise(IsaToken.OPTIONAL_THE.toString() + IsaToken.parenthesise(pattern)));
            //}
            //else
            {
                //TODO: if owner is null raise a warning? 
                sb.append(pattern);
            }
        }
        return sb.toString();
    }

    /**
     * Some VDM identifiers will cause trouble in Isabelle, like "o" (composition), "MAX" etc. Check them all here.
     */
    protected void checkValidIsaIdentifier()
    {
        if (isaToken().equals(IsaToken.IDENTIFIER) && !IsaToken.validIsaIdentifier(getPattern()))
            report(IsaErrorMessage.ISA_INVALID_IDENTIFIER_1P, getPattern());   
    }

    public abstract String getPattern();

	public abstract <R, S> R apply(TRPatternVisitor<R, S> visitor, S arg);

}
