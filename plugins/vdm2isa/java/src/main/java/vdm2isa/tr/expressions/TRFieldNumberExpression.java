package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexIntegerToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRType;

/**
 * Field number expressions (e.g., x.#n) have to be transformed to the adequate tuple product/pair projection
 * (see TRProductType). 
 */
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
            report(IsaErrorMessage.VDMSL_INVALID_TUPLE_TYPE_3P, tuple.translate(), field.toString(), type.getClass().getName());
        else if (this.field.value <= 0 || this.field.value > getProductType().types.size())
            report(IsaErrorMessage.VDMSL_INVALID_TUPLE_PROJECTION_3P, field.value, getProductType().types.size());
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CROSSPROD;
    }

    protected TRProductType getProductType()
    {
        return (TRProductType)type;
    }

    @Override
    public String translate() {
        assert field.value > 0 && field.value <= getProductType().types.size();
        //if (GeneralisaPlugin.getErrorCount() == 0)
        return TRProductType.fieldProjection(field.value - 1, getProductType().types.size(), 
            IsaToken.parenthesise(tuple.translate()));
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFieldNumberExpression(this, arg);
	}
}
