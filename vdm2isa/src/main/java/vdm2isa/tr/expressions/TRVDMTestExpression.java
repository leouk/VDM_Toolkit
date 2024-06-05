package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.definitions.TRTypeDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRType;

/**
 * Super class for VDM is_X and narrow expressions.
 */
public abstract class TRVDMTestExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
    public final TCNameToken typename;
    public final TRType basictype;
    public final TRExpression test;
    public final TRDefinition typedef;

    public TRVDMTestExpression(LexLocation location, TCExpression tc, TCNameToken typename, TRType basictype, TRExpression test, TRDefinition typedef, TRType exptype)
    {
        super(location, tc, exptype);
        this.typename = typename;
        this.basictype = basictype;
        this.test = test;
        this.typedef = typedef;
    }

    @Override 
    public void setup()
    {
        super.setup();
        if (basictype != null && typename != null)
            report(IsaErrorMessage.VDMSL_INVALID_TESTEXPR_3P, getClass().getSimpleName(), typename.toString(), basictype.getClass().getSimpleName());
        // this is allowed! e.g., is_(s, seq of nat)! As opposed to is_T(s) for T = seq of nat for the type name
        //if (basictype != null && !(basictype instanceof TRBasicType))
        //    warning(IsaWarningMessage.VDMSL_INVALID_EXPR_TYPE_2P, getClass().getSimpleName(), basictype.getClass().getSimpleName()); 
        TRNode.setup(basictype, test, typedef);
    }

    @Override
    public String toString()
    {
        return getClass().getName () + " for " +
            "\n\t typename = " + String.valueOf(typename) +
            "\n\t basictype= " + String.valueOf(basictype) + //(basictype != null ? basictype.translate() : "null") +
            "\n\t test     = " + String.valueOf(test) + //(test != null ? test.translate() : "null") +
            "\n\t typedef  = " + String.valueOf(typedef); //(typedef != null ? typedef.translate() : "null");
    }

    public boolean isBasicTyped()
    {
        return basictype != null && basictype instanceof TRBasicType && typename == null;
    }

    public boolean isNameTyped()
    {
        return basictype == null && typename != null && typedef != null;
    }

    /**
     * 
     * @return
     */
    protected TRType getTestType()
    {
        return isBasicTyped() ? basictype : 
            //TODO @NB this might not always be a TRTypeDefinition? If so, how to get the "type" of typename? 
            typedef != null && typedef instanceof TRTypeDefinition ? 
                ((TRTypeDefinition)typedef).type : TRExpression.unknownType(location);
    }

    @Override 
	protected TRType getBestGuessType()
	{
		TRType result; 
        if (isBasicTyped())
            result = basictype;
		else if (typedef instanceof TRLocalDefinition)
			result = ((TRLocalDefinition)typedef).getType();
		else if (typedef instanceof TRExplicitFunctionDefinition)
			result = ((TRExplicitFunctionDefinition)typedef).getType().getResultType();
		else
            //TODO any more missing typedef options?
			result = super.getType();
		return result;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseVDMTestExpression(this, arg);
	}
}
