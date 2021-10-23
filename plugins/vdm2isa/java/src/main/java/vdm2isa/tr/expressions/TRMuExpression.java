package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRMuExpression extends TRExpression {

	private static final long serialVersionUID = 1L;

    private final TRExpression record;
    private final TRRecordModifierList modifiers;

    public TRMuExpression(LexLocation location, TRExpression record, TRRecordModifierList modifiers)
    {
        super(location);    
        this.record = record;
        this.modifiers = modifiers;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(record.translate()) + 
            IsaToken.bracketit(IsaToken.LRECORD, modifiers.translate(), IsaToken.RRECORD);
    }


}
