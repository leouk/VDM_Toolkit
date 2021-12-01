package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.ast.lex.LexIntegerToken;
import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRType;

/**
 * Field number expressions (e.g., x.#n) have to be transformed to the adequate tuple product/pair projection
 * (see TRProductType). 
 */
public class TRFieldNumberExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
    public final TRExpression tuple;
    public final LexIntegerToken field; 
    public final TRType type;

    public TRFieldNumberExpression(TRExpression tuple, LexIntegerToken field, TRType type, TRType exptype)
    {
        super(tuple != null ? tuple.location : LexLocation.ANY, exptype);
        this.tuple = tuple;
        this.field = field;
        this.type = type;
    }

    @Override
    public void setup()
    {
        super.setup();
        if (!(type instanceof TRProductType))
            report(IsaErrorMessage.VDMSL_INVALID_TUPLE_TYPE_3P, tuple.translate(), field.toString(), type.getClass().getSimpleName());
        else if (this.field.value <= 0 || this.field.value > getProductType().types.size())
            report(IsaErrorMessage.VDMSL_INVALID_TUPLE_PROJECTION_3P, field.value, getProductType().types.size());
        TRNode.setup(tuple, type);
    }

    /**
     * Specifc type within the product for this product type
     */
    @Override 
    protected TRType getBestGuessType()
    {
        if (type instanceof TRProductType)
        {
            assert field.value <= Integer.MAX_VALUE;
            int index = (int)field.value;
            return getProductType().types.get(index);                
        }
        else 
            return super.getType();
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CROSSPROD;
    }

    /**
     * Overall product type within this field number expression
     * @return
     */
    protected TRProductType getProductType()
    {
        return (TRProductType)type;
    }

    @Override
    public String translate() {
        assert field.value > 0 && field.value <= getProductType().types.size();
        // field value is adjusted to the tuple 0-based index (i.e. f.#n = n'th - 1 index within types)
        return TRProductType.fieldProjection(field.value - 1, getProductType().types.size(), 
            IsaToken.parenthesise(tuple.translate()));
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseFieldNumberExpression(this, arg);
	}
}
