package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.util.Utils;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

public class TRFunctionInstantiationExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    private final TRExpression function;
    private final TRTypeList unresolved;
    private final TRTypeList actualTypes;
    private final TRFunctionType type;

    private final TRExplicitFunctionDefinition expdef;

    //TODO get the other stuff
    public TRFunctionInstantiationExpression(TRExpression function, TRFunctionType type, 
        TRTypeList unresolved, TRTypeList actualTypes, TRExplicitFunctionDefinition expdef)
    {
        super(function);
        this.function = function;
        this.type = type;
        this.actualTypes = actualTypes;
        this.unresolved = unresolved;
        this.expdef = expdef;
    }

    @Override
    public TRType getType()
    {
        return type.result;
    }

    @Override
    public String toString()
    {
        return function.toString() + (type != null ? "[" + type.toString() + "]" : "");
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
