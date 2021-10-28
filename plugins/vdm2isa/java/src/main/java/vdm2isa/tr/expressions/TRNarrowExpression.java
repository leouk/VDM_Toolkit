package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import plugins.Vdm2isaPlugin;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRType;

/**
 * Isabelle only allows type casting between "proper" types (and their classes), rather than various forms of type synonyms.  
 * Thus, some narrow expressions will fail to translate and will require the user to properly instantiate the offending 
 * type within the target type class of interest related to the narrowed type.
 */
public class TRNarrowExpression extends TRVDMTestExpression {

	private static final long serialVersionUID = 1L;

    public TRNarrowExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test)
    {
        super(location, typename, basictype, test);
    }
    
    @Override
    public String translate() {
        String problem = "VDM narrow expressions might create Isabelle type errors!";
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
            warning(11000, problem);
            return IsaToken.parenthesise(IsaToken.parenthesise(test.translate()) + 
                IsaToken.TYPEOF + basictype.translate()) +
                IsaToken.comment(problem);
        } else if (isNameTyped())
        {
            warning(11000, problem);
            return IsaToken.parenthesise(IsaToken.parenthesise(test.translate()) + 
                IsaToken.TYPEOF + typename.getName()) +
                IsaToken.comment(problem);
        }
        else
        {
            report(10001, "Cannot translate this VDM narrow expression to Isabelle");
            return IsaToken.ERROR.toString();
        }
    }
}
