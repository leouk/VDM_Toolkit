package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;

/**
 * Map comprehension in Isabelle is a particular kind of lambda expression
 *      { x |-> free-y | x in set S & P(x, free-y) }
 *      =
 *      (lambda x: typeOf(S) & if inv_typeOf(S) x and x in set S and P(x,free-y) then free-y else nil) 
 * 
 * More generally 
 *      { first.dom |-> first.range | bindings & predicate }
 *      =
 *      (% dummy0::typeOf(first.dom) . 
 *          if bindings.getBindingExpression() /\ predicate /\ dummy0 = first.dom then
 *              Some (dummy1::typeOf(first.range))
 *          else
 *              None
 *      )
 * More concretely
 *      { x+y |-> z | x in set R, y in set S, z in set T }
 *      =
 *      (% (dummy::VDMNat1) . 
 *          if  (? x y z . x : R /\ y : S /\ z : T /\ dummy = x+y) then
 *              
 *      )
 */
public class TRMapCompExpression extends TRAbstractCompExpression {

    private final TRLambdaExpression mapComp;

    public TRMapCompExpression(LexLocation location, 
        TRMapletExpression first, TRMultipleBindList bindings,
        TRExpression predicate, TRDefinition def, TRType exptype) {
        super(location, first, bindings, predicate, def, exptype);

        //bindings.getBindingsExpression();
        // LexLocation location, TRTypeBindList bindList, TRExpression expression,
        // TRFunctionType type, TRPatternList paramPatterns, TRDefinitionList paramDefinitions, TRDefinition def,
        // TRType exptype
        this.mapComp = new TRLambdaExpression(
             location, null/*bindings*/, null/*expression */, getMapType().getFunctionType(), null, null, 
             def, getMapletExpr().getType());
        this.mapComp.isMapComp = true;
    }

    public TRMapType getMapType()
    {
        return (TRMapType)exptype;
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
       return "";//this.mapComp.translate();
    }
    
}
