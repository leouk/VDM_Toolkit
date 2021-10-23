package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexIntegerToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRProductType;

public class TRFieldNumberExpression extends TRExpression {
    
    private final TRExpression tuple;
    private final LexIntegerToken field; 
    private final TRProductType type;

    public TRFieldNumberExpression(TRExpression tuple, LexIntegerToken field)
    {
        super(tuple);
        this.tuple = tuple;
        this.field = field;
        //TODO has to get this info from TCFieldNumberExpression, but it's private . 
        this.type = null;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return TRProductType.fieldProjection(field.value, type.types.size(), 
            IsaToken.LPAREN.toString() + tuple.translate() + IsaToken.RPAREN.toString());
    }
}
