package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

/**
 * Isabelle only allows type casting between "proper" types (and their classes), rather than various forms of type synonyms.  
 * Thus, some narrow expressions will fail to translate and will require the user to properly instantiate the offending 
 * type within the target type class of interest related to the narrowed type.
 */
public class TRNarrowExpression extends TRVDMTestExpression {

	private static final long serialVersionUID = 1L;

    public final TRType testtype;

    public TRNarrowExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test, TRDefinition typedef, TRType testtype, TRType exptype)
    {
        super(location, typename, basictype, test, typedef, exptype);
        this.testtype = testtype;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(testtype);
        //System.out.println(toString());
    }

    @Override
    public String toString()
    {
        return super.toString() + "\n\t exptype  = " + String.valueOf(testtype);//(exptype != null ? exptype.translate() : "null");
    }
    
    @Override
    public IsaToken isaToken() {
        return IsaToken.NARROW;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        String testStr = IsaToken.parenthesise(test.translate());
        if (isBasicTyped())
        {
            switch (basictype.isaToken())
            {
                case NAT: 
                case NAT1:
                case INT:
                case RAT:
                case REAL:
                    // presume it's a real or rat to narrow from; floor_ceiling is a type class that encompass all these
                    // vdm_narrow_real :: "('a::floor_ceiling) => VDMInt"
                    sb.append(IsaToken.VDMINT_NARROW.toString());
                    sb.append(" ");
                                        // presume the widest type for testStr, even if not quite "real"
                    sb.append(IsaToken.parenthesise(testStr + IsaToken.TYPEOF.toString() + IsaToken.REAL.toString())); 
                    break;
                case BOOL:
                case CHAR:
                case TOKEN:
                default:
                    warning(IsaWarningMessage.ISA_TYPED_NARROW_1P, basictype.isaToken().toString());
                    sb.append(IsaToken.comment(IsaWarningMessage.ISA_TYPED_NARROW_1P.format(basictype.isaToken().toString()), getFormattingSeparator()));
                    break;
            }
        } 
        else if (isNameTyped())
        { 
            String typeDefStr = typedef.translate();
            warning(IsaWarningMessage.ISA_TYPED_NARROW_1P, typeDefStr);
            sb.append(IsaToken.comment(IsaWarningMessage.ISA_TYPED_NARROW_1P.format(typeDefStr), getFormattingSeparator()));
            sb.append(IsaToken.parenthesise(testStr + IsaToken.TYPEOF.toString() + typename.toString()));              
        }
        else
        {
            // should never reach really for valid TC tree
            report(IsaErrorMessage.VDMSL_INVALID_TESTEXPR_3P, getClass().getSimpleName(), 
                String.valueOf(basictype), String.valueOf(typename));
            // basictype == null || !basictype instanceof TRBasicType || typename != null)
            // &&
            // (basictype != null || typename == null)
            // =
            // (basictype != null || typename == null) && basictype == null
            // ||
            // (basictype != null || typename == null) && !basictype instanceof TRBasicType
            // ||
            // (basictype != null || typename == null) && typename != null
            // =
            // (basictype != null && basictype == null || typename == null && basictype == null)
            // ||
            // (basictype != null && !basictype instanceof TRBasicType || typename == null && !basictype instanceof TRBasicType)
            // ||
            // (basictype != null && typename != null || typename == null && typename != null)
            // =
            // (typename == null && basictype == null)
            // ||
            // (basictype != null || typename == null) && !basictype instanceof TRBasicType
            // ||
            // (basictype != null && typename != null)

        }
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseNarrowExpression(this, arg);
	}
}
