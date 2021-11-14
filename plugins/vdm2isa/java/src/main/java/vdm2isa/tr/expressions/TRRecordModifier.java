package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRRecordModifier extends TRExpression 
{
    private static final long serialVersionUID = 1L;
    private final TCIdentifierToken tag;
    private final TRExpression value; 

    protected TRRecordType recordType;

    public TRRecordModifier(TCIdentifierToken tag, TRExpression value)
    {
        super(tag.getLocation(), value.getType());
        this.tag = tag;
        this.value = value;
        // empty if can't yet know which record this modification is associated with; TRMuExpression must set this once known.
        this.recordType = null;
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
    public String translate() {
        return IsaTemplates.isabelleRecordFieldName(recordType.getName(), tag.toString()) + 
            " " + isaToken().toString() + " " + value.translate();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseRecordModifier(this, arg);
	}
            
}
