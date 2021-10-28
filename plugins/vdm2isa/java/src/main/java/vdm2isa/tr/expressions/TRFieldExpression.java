package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRFieldExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
    private final TRExpression object;
    private final TCIdentifierToken field; 

    public TRFieldExpression(TRExpression object, TCIdentifierToken field)
    {
        super(object);
        this.object = object;
        this.field = field;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF; 
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(
                    field.getName() + " " +
                    IsaToken.parenthesise(object.translate())
                );
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFieldExpression(this, arg);
	}
}
