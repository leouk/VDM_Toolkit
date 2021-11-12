package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.types.TRType;

public class TRIotaExpression extends TRExpression {

    private TRMultipleBind bind;
    private TRExpression predicate;
    
    public TRIotaExpression(LexLocation location, TRMultipleBind bind, TRExpression predicate)
    {
        super(location);
        this.bind = bind;
        this.predicate = predicate;
    }

	@Override
	public TRType getType()
	{
		return predicate.getType();
	}

    @Override
    protected void setup()
	{
        super.setup();
	 	setFormattingSeparator(" ");
        setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
	}

    @Override
    public IsaToken isaToken() {
       return IsaToken.IOTA;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(isaToken().toString());
        sb.append(getFormattingSeparator());
        // don't translate the bind, but the pattern within; bind translate is after 
        sb.append(bind.plist.get(0).translate());//sb.append(bind.translate());
        sb.append(IsaToken.POINT.toString());
        sb.append(getFormattingSeparator());
        StringBuilder bindStr = new StringBuilder();
        bindStr.append(bind.invTranslate());
        if (bindStr.length() > 0)
        {
            bindStr.append(getInvTranslateSeparator());
        }
        bindStr.append(predicate.translate());
        sb.append(IsaToken.parenthesise(bindStr.toString()));
        return IsaToken.parenthesise(sb.toString()); 
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseIotaExpression(this, arg);
	}
}
