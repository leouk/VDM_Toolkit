package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.types.TRType;

/**
 * Map comprehension in Isabelle is a particular kind of lambda expression
 *      { x |-> free-y | x in set S & P(x, free-y) }
 *      =
 *      (lambda x: typeOf(S) & if inv_typeOf(S) x and x in set S and P(x,free-y) then free-y else nil) 
 */
public class TRMapCompExpression extends TRAbstractCompExpression {

    private final TRLambdaExpression mapComp;

    public TRMapCompExpression(LexLocation location, 
        TRMapletExpression first, TRMultipleBindList bindings,
        TRExpression predicate, TRDefinition def, TRType exptype) {
        super(location, first, bindings, predicate, def, exptype);

        //bindings.getBindingsExpression();
        this.mapComp = null;
        // this.mapComp = new TRLambdaExpression(
        //     location, bindings, expression, type, paramPatterns, paramDefinitions, 
        //     def, getMapletExpr().getType());//? or exptype?
        this.mapComp.isMapComp = true;
    }

    public TRMapletExpression getMapletExpr()
    {
        return (TRMapletExpression)first;
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseMapCompExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.LAMBDA;
    }

    @Override
    protected TRType getBestGuessType()
    {
        return getMapletExpr().getType();
    }

    @Override
    public String translate() {
       return this.mapComp.translate();
    }
    
}
