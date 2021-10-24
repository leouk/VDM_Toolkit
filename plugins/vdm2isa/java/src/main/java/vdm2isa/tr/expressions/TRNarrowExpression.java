package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRType;

public class TRNarrowExpression extends TRVDMTestExpression {

	private static final long serialVersionUID = 1L;

    public TRNarrowExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test)
    {
        super(location, typename, basictype, test);
    }
    
    @Override
    public String translate() {
        if (isBasicTyped())
        {
            switch (basictype.isaToken())
            {
                case NAT: 
                case NAT1:
                case INT:
                case RAT:
                case REAL:
                case BOOL:
                case CHAR:
                case TOKEN:
                default:
                    break;
            }
            return IsaToken.parenthesise(IsaToken.parenthesise(test.translate()) + 
                IsaToken.TYPEOF + basictype.translate()) +
                IsaToken.comment("VDM narrow expressions might create Isabelle type errors!");
        } else if (isNameTyped())
        {
            return IsaToken.parenthesise(IsaToken.parenthesise(test.translate()) + 
                IsaToken.TYPEOF + typename.getName()) +
                IsaToken.comment("VDM narrow expressions might create Isabelle type errors!");

        }
        else
            return IsaToken.comment("Cannot translate this VDM narrow expression to Isabelle");
    }
    
}
