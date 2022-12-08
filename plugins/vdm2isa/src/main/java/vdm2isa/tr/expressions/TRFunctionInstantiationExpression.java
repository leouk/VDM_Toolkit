package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCFuncInstantiationExpression;

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
    public final TRTypeList actualTypes;
    public final TRFunctionType type;

    public final TRExplicitFunctionDefinition expdef;
    public final TRExplicitFunctionDefinition impdef; //TODO! should be implicit def

    public TRFunctionInstantiationExpression(TCFuncInstantiationExpression tc, TRExpression function, TRFunctionType type, 
        TRTypeList actualTypes, TRExplicitFunctionDefinition expdef, TRType exptype)
    {
        super(function != null ? function.location : LexLocation.ANY, tc, exptype);
        this.function = function;
        this.type = type;
        this.actualTypes = actualTypes;
        this.expdef = expdef;
        this.impdef = null;
    }
    
    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(function, type, actualTypes, expdef, impdef);
    }

    @Override
    protected TRType getBestGuessType()
    {
        return type.getResultType();
    }

    @Override
    public String toString()
    {
        return function.toString() + "[" + String.valueOf(actualTypes) + "]";
//            (type != null ? "[" + type.toString() + "]" : "");
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseFunctionInstantiationExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.APPLY;
    }

    /**
     * For function instantiation, just translate the function name. The underlying TRApplyExpr has to pick the actual
     * parameters to add as input parameters for corresponding parameteric type invariant checking.
     */
    @Override
    public String oldtranslate() {
        return function.oldtranslate();
    }
    
}
