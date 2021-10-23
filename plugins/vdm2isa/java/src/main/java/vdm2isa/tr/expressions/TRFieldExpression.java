package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.lex.IsaToken;

public class TRFieldExpression extends TRExpression {
    
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
        return IsaToken.LPAREN.toString() +
            field.getName() + " " +
            IsaToken.LPAREN.toString() + 
            object.translate() + 
            IsaToken.RPAREN.toString() +
            IsaToken.RPAREN.toString();
    }
}
