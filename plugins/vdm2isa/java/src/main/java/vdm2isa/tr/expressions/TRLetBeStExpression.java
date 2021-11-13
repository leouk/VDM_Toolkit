package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRMultiBindListDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.types.TRType;

public class TRLetBeStExpression extends TRVDMLocalDefinitionListExpression {
    
    private static final long serialVersionUID = 1L;
    private final TRMultipleBind bind;
    private final TRExpression suchThat;
    private final TRMultiBindListDefinition def;

	public TRLetBeStExpression(LexLocation location, TRMultipleBind bind, TRExpression suchThat, TRExpression value, TRMultiBindListDefinition def, TRType exptype) {
        super(location, value, exptype);
        this.bind = bind;
        this.suchThat = suchThat;
        this.def = def; 
    }

    @Override
    protected void setup()
	{
        super.setup();
        setFormattingSeparator("\n\t\t");
	 	setInvTranslateSeparator(" " + IsaToken.AND.toString() + " ");
	}

    @Override
    public String toString()
    {
        return "LetBeStDef " + String.valueOf(bind) + " be st " + 
            String.valueOf(suchThat) + " in \n\t" + String.valueOf(expression);
    }

    @Override
    public IsaToken isaToken() {
       return IsaToken.SOME;
    }

    public String translate() {
        StringBuilder sb = new StringBuilder();
        // let x in S be st P(x) in exp(x)
        // =
        // (let x = v1; y = v2 in (x::VDMNat) (y::VDMNat1) in 
        //      exp(x, y)
        // )
        sb.append(getFormattingSeparator());
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(bind.translate());
        sb.append(getFormattingSeparator());
        sb.append(IsaToken.IN.toString());
        sb.append(getFormattingSeparator() + "\t");
        sb.append(invTranslate());
        return IsaToken.parenthesise(sb.toString());
    }

    /**
     * Local definitions invariant translation
     */
    @Override
    public String localInvTranslate()
    {
        //String old = localDefs.setInvTranslateSeparator(getInvTranslateSeparator());
        //String result = localDefs.invTranslate();
        //localDefs.setInvTranslateSeparator(old);
        return "";
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLetBeStExpression(this, arg);
	}
}
