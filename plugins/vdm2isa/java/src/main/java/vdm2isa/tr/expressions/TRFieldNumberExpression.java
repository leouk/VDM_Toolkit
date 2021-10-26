package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexIntegerToken;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRType;

public class TRFieldNumberExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
    private final TRExpression tuple;
    private final LexIntegerToken field; 
    private final TRType type;

    public TRFieldNumberExpression(TRExpression tuple, LexIntegerToken field, TRType type)
    {
        super(tuple);
        this.tuple = tuple;
        this.field = field;
        this.type = type;
        if (!(type instanceof TRProductType))
            TypeChecker.report(IsaToken.error(3), "Invalid type for tuple projection expression " + tuple.translate() + ".#" + field.toString() + " = " + type.getClass().getName(), location);
        if (this.field.value <= 0 || this.field.value > getProductType().types.size())
            TypeChecker.report(IsaToken.error(4), "Invalid tuple projection field (" + this.field.value + ") is bigger than tuple size (" + getProductType().types.size() + ")", location); 
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    protected TRProductType getProductType()
    {
        return (TRProductType)type;
    }

    @Override
    public String translate() {
        assert field.value > 0 && field.value <= getProductType().types.size();
        return TRProductType.fieldProjection(field.value - 1, getProductType().types.size(), 
            IsaToken.parenthesise(tuple.translate()));
    }
}
