package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRMuExpression extends TRExpression {

	private static final long serialVersionUID = 1L;

    private final TRExpression record;
    private final TRRecordModifierList modifiers;

    public TRMuExpression(LexLocation location, TRExpression record, TRRecordModifierList modifiers)
    {
        super(location);    
        this.record = record;
        this.modifiers = modifiers;
        TRType t = record.getRecordType();
        if (t instanceof TRRecordType)
            this.modifiers.setRecordType((TRRecordType)t);
    }

    @Override
    public TRType getType()
    {
        TRType result = record.getRecordType();
        if (!(result instanceof TRRecordType))
            report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getName(), isaToken().toString(), "2", "expects record type");
        return result;
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
