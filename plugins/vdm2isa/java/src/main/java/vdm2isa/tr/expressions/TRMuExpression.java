package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCMuExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRMuExpression extends TRExpression {

	private static final long serialVersionUID = 1L;

    public final TRExpression record;
    public final TRRecordModifierList modifiers;
    private boolean hasReportedGuessedType;

    public TRMuExpression(LexLocation location, TCMuExpression tc, TRExpression record, TRRecordModifierList modifiers, TRType exptype)
    {
        super(location, tc, exptype);    
        this.record = record;
        this.modifiers = modifiers;
        this.hasReportedGuessedType = false;
    }

    @Override
    public void setup()
    {
        super.setup();
        assert record != null;
        TRType t = record.getRecordType();
        if (t instanceof TRRecordType)
            this.modifiers.setRecordType((TRRecordType)t);
        TRNode.setup(record, modifiers); 
    }

    @Override
    protected TRType getBestGuessType()
    {
        TRType result = record.getRecordType();
        if (!(result.ultimateType() instanceof TRRecordType) && !hasReportedGuessedType)
        {
            report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, getClass().getSimpleName(), isaToken().toString(), "2", "expects record type");
            hasReportedGuessedType = true;
        }
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
