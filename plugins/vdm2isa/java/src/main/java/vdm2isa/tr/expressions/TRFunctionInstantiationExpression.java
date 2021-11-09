package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.util.Utils;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRTypeList;

public class TRFunctionInstantiationExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    private final TRExpression function;
    private final TRTypeList types;

    //TODO get the other stuff
    public TRFunctionInstantiationExpression(TRExpression function, TRTypeList types)
    {
        super(function);
        this.function = function;
        this.types = types;
    }

    @Override
    public String toString()
    {
        return function.toString() + (types != null && types.size() > 0 ? "[" + Utils.listToString(types, ",") + "]" : "");
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        throw new UnsupportedOperationException();
    }

    @Override
    public IsaToken isaToken() {
        throw new UnsupportedOperationException();
    }

    @Override
    public String translate() {
        throw new UnsupportedOperationException();
    }
    
}
