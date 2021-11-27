package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRField;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRFieldExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
    private final TRExpression object;
    private final TCIdentifierToken field;
    private boolean hasReportedGuessTypeIssue;

    public TRFieldExpression(TRExpression object, TCIdentifierToken field, TRType exptype)
    {
        super(object != null ? object.location : LexLocation.ANY, exptype);
        this.object = object;
        this.field = field;
        this.hasReportedGuessTypeIssue = false;
        //System.out.println(toString());
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(object);
    }

    public TRExpression recordExpression()
    {
        return object;
    }

    /**
     * Field expression record type is its inner object type [chased for renamings?]
     */
    @Override
    protected TRType doGetRecordType()
    {
        return getUltimateType(object.getType());
    }

    @Override 
    protected TRType getBestGuessType()
    {
        TRType t = object.getType();
        if (!(t instanceof TRRecordType) && !hasReportedGuessTypeIssue)
        {
            report(IsaErrorMessage.VDMSL_FIELD_MISSING_RECORDTYPE_1P, field.toString());
            hasReportedGuessTypeIssue = true;
        }
        if (t instanceof TRRecordType)
        {
            TRRecordType rtype = (TRRecordType)t;
            TRField rfield = rtype.findField(field.getName());
            if (rfield != null)
                t = rfield.getInnerType();
        }
        return t;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.POINT; 
    }

    @Override
    public String translate() {
        // attempt to get underlying object record type name to change record field name according to TRRecordType TLD considerations 
        return IsaToken.parenthesise(
                    IsaTemplates.isabelleRecordFieldName(object.getRecordType().getName(), field.getName()) + " " +
                    IsaToken.parenthesise(object.translate())
                );
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFieldExpression(this, arg);
	}
}
