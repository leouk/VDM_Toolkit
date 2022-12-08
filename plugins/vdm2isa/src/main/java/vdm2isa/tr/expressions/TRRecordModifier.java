package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCRecordModifier;
import com.fujitsu.vdmj.tc.expressions.TCTupleExpression;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRRecordModifier extends TRExpression 
{
    private static final long serialVersionUID = 1L;
    public final TCIdentifierToken tag;
    public final TRExpression value; 
    private final TCRecordModifier vdmRecordModifier;
    protected TRRecordType recordType;

    private static TCTupleExpression figureOutRecordModifier(TCRecordModifier tc)
    {
        TCExpressionList args = new TCExpressionList();
        TCNameToken name = IsaToken.newNameToken(tc.tag.getLocation(), tc.tag.getLocation().module, tc.tag.getName());
        args.add(new TCVariableExpression(tc.tag.getLocation(), name, tc.tag.getName()));
        args.add(tc.value);
        TCTupleExpression result = new TCTupleExpression(tc.tag.getLocation(), args);
        return result; 
    }

    public TRRecordModifier(TCRecordModifier tc, TCIdentifierToken tag, TRExpression value)
    {
        super(tag != null ? tag.getLocation() : LexLocation.ANY, 
            figureOutRecordModifier(tc), value != null ? value.getType() : TRExpression.unknownType(tag != null ? tag.getLocation() : LexLocation.ANY));
        this.vdmRecordModifier = tc;
        this.tag = tag;
        this.value = value;
        // empty if can't yet know which record this modification is associated with; TRMuExpression must set this once known.
        this.recordType = null;
    }

    public TCRecordModifier getVDMRecordModifier()
    {
        return vdmRecordModifier;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(value, recordType);
    }

    @Override
    protected TRType getBestGuessType()
    {
        return value.getType();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD_MODIFIER;
    }

    @Override
    public String oldtranslate() {
        return IsaTemplates.isabelleRecordFieldName(recordType.getName(), tag.toString()) + 
            " " + isaToken().toString() + " " + value.oldtranslate();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseRecordModifier(this, arg);
	}
            
}
