package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

/**
 * Super class for VDM expressions with declared local definitions (e.g. lambda, let, etc.) 
 */
public abstract class TRVDMLocalDefinitionListExpression extends TRExpression {
    
    private static final long serialVersionUID = 1L;
    protected final TRExpression expression;

    public TRVDMLocalDefinitionListExpression(LexLocation location, TRExpression expression)
    {
        super(location);
        this.expression = expression;
    }

    @Override
    protected void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t");
    } 

    @Override
	public TRType getType()
	{
		return expression.getType();
	}


    public abstract String localInvTranslate();

    @Override
    public String invTranslate()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.LPAREN.toString());
        sb.append(IsaToken.IF.toString());
        sb.append(" ");
        sb.append(localInvTranslate());
        sb.append(" ");
        sb.append(IsaToken.THEN.toString());
        sb.append(getFormattingSeparator() + "\t");
        sb.append(expression.translate());        
        sb.append(getFormattingSeparator() + " ");
        sb.append(IsaToken.ELSE.toString());
        sb.append(getFormattingSeparator() + "\t");
        sb.append(IsaToken.UNDEFINED.toString());
        sb.append(getFormattingSeparator()); 
        sb.append(IsaToken.RPAREN.toString());
        sb.append(getFormattingSeparator());
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseVDMLocalDefinitionListExpression(this, arg);
	}
}
