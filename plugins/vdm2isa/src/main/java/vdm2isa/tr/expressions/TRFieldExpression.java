package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCFieldExpression;
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
    public final TRExpression object;
    public final TCIdentifierToken field;
    private boolean hasReportedGuessTypeIssue;

    public TRFieldExpression(TCFieldExpression tc, TRExpression object, TCIdentifierToken field, TRType exptype)
    {
        super(object != null ? object.location : LexLocation.ANY, tc, exptype);
        this.object = object;
        this.field = field;
        this.hasReportedGuessTypeIssue = false;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(object);
        //System.out.println(toString());
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
        return object.getType().ultimateType();//getUltimateType(object.getType());
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
        // inner fields must have record type!
        //object instanceof TRFieldExpression => object.exptype instanceof TRRecordType!
        assert !(object instanceof TRFieldExpression) || (object.exptype instanceof TRRecordType);

        // attempt to get underlying object record type name to change record field name according to TRRecordType TLD considerations 
        return IsaToken.parenthesise(
                    IsaTemplates.isabelleRecordFieldName(
                        // for nested fields, be careful: the type name of the outer fields is already 
                        // known: must be a record type of course, so get that name. 
                        // A::a:int; B::b:A; C::c:B inv x == x.c.b.a > 10 =isa> (a_A (b_B (c_C x))),
                        // i.e. only chase the record type for when handling the "final" field in the chain 
                        (object instanceof TRFieldExpression ? 
                            object.getType().getName() : 
                            object.getRecordType().getName()), field.getName()) 
                    + 
                    IsaToken.SPACE.toString() 
                    +
                    typeConvertTranslate(object, object.getType())
                );
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFieldExpression(this, arg);
	}

    public static final TRFieldExpression newFieldExpression(TRExpression object, TCIdentifierToken field, TRType exptype)
    {
        TRFieldExpression result = new TRFieldExpression(
                new TCFieldExpression(object.getVDMExpr(), field, null),
                object, field, exptype);        
        TRNode.setup(result);
        return result;
    }
}
