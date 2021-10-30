package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRMuExpression extends TRExpression {

	private static final long serialVersionUID = 1L;

    private final TRExpression record;
    private final TRRecordModifierList modifiers;

    public TRMuExpression(LexLocation location, TRExpression record, TRRecordModifierList modifiers)
    {
        super(location);    
        this.record = record;
        this.modifiers = modifiers;
        this.modifiers.setRecordTypeName(record.getRecordTypeName());
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD_MODIFIER;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(record.translate()) + 
            IsaToken.bracketit(IsaToken.LRECORD, modifiers.translate(), IsaToken.RRECORD);
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMuExpression(this, arg);
	}
}
