package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

public class TRFunctionInstantiationExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    public final TRExpression function;
    public final TRTypeList unresolved;
    public final TRTypeList actualTypes;
    public final TRFunctionType type;

    public final TRExplicitFunctionDefinition expdef;
    public final TRExplicitFunctionDefinition impdef; //TODO! should be implicit def

    public TRFunctionInstantiationExpression(TRExpression function, TRFunctionType type, 
        TRTypeList unresolved, TRTypeList actualTypes, TRExplicitFunctionDefinition expdef, TRType exptype)
    {
        super(function != null ? function.location : LexLocation.ANY, exptype);
        this.function = function;
        this.type = type;
        this.actualTypes = actualTypes;
        this.unresolved = unresolved;
        this.expdef = expdef;
        this.impdef = null;
    }
    
    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(function, type, actualTypes, unresolved, expdef, impdef);
    }

    @Override
    protected TRType getBestGuessType()
    {
        return type.getResultType();
    }

    @Override
    public String toString()
    {
        return function.toString() + (type != null ? "[" + type.toString() + "]" : "");
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseFunctionInstantiationExpression(this, arg);
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
