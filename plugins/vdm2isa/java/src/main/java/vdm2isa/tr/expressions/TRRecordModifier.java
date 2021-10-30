package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRRecordModifier extends TRExpression 
{
    private static final long serialVersionUID = 1L;
    private final TCIdentifierToken tag;
    private final TRExpression value; 

    protected String recordTypeName;

    public TRRecordModifier(TCIdentifierToken tag, TRExpression value)
    {
        super(tag.getLocation());
        this.tag = tag;
        this.value = value;
        // empty if can't yet know which record this modification is associated with; TRMuExpression must set this once known.
        this.recordTypeName = "";
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD_MODIFIER;
    }

    @Override
    public String translate() {
        return IsaTemplates.isabelleRecordFieldName(recordTypeName, tag.toString()) + 
            " " + isaToken().toString() + " " + value.translate();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseRecordModifier(this, arg);
	}
            
}
