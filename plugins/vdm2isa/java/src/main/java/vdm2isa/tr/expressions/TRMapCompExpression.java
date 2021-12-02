package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.TCVisitorSet;
import com.fujitsu.vdmj.tc.expressions.EnvTriple;
import com.fujitsu.vdmj.tc.expressions.visitors.TCExpressionVisitor;
import com.fujitsu.vdmj.tc.expressions.visitors.TCGetFreeVariablesVisitor;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindKind;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.patterns.TRMultipleTypeBind;
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

    private TRLambdaExpression mapComp;
    private boolean existentialDomain;
    private boolean existentialRange;
    private boolean hasRangeBinding;
    private TRExpression domainSet;
    private TRExpression rangeSet;
    private TRExpression domLambda;
    private TRExpression rangeLambda;
    private TRExpression predLambda;

    /**
     * TCMapCompExpression has the structure:
     *      { first.dom |-> first.rng | bindings & predicate }, 
     *      exptype = TCMapType(first.dom, first.rng)
     * 
     * which will become somewhat (but not quite) like (i.e. see MapCompStudy.thy + VDMToolkit.thy for details):
     *      (lambda dummy: first.dom.exptype & 
     *          if (exists bindings.translate() & 
     *                  bindings.invTranslate() and 
     *                  first.rng.invTranslate and
     *                  dummy = first.dom and
     *                  predicate)
     *          then
     *              first.rng
     *          else
     *              nil 
     *      ),
     *      exptype = TRFunctionType(TRTypeList(first.dom.exptype), TROptionalType(first.rng.exptype))!
     */
    /**
     * From the MapCompStudy.thy, we identified that a general (yet not fully general) map comprehension pattern
     * is possible, such that we don't need to create a monster-lambda, and instead delegate to operators within
     * Isabelle that sets up the corresponding Lambda that would otherwise be translated.
     * 
     * In practice, that means only two bindings are allowed maximally (one for dom one for ran), but it also means
     * the user would get some help with useful lemmas for that specific monster-lambda construct. On balance this 
     * is a reasonable design decision, if a limiting one for examples where more than two bindings exist. 
     * 
     * Notice also that certain domain/range bindings, might entail a complex (existential) set comprehension, which
     * is not entirely obvious for the user, but will play a part (in complicating) proofs. For example
     * 
     *      v98 : map nat1 to int = { x+y |-> 10 | x in set {1,2,3}, y in set {4,5,6} }
     * 
     * the domain binding set is not {1,2,3}, but { x+y | x in set {1,2,3}, y in set {4,5,6} } = {5,...,9}!
     * 
     * Moreover, users cannot mix set/seq with type bindings either, but they can have set/seq alone
     * @param location
     * @param first
     * @param bindings
     * @param predicate
     * @param def
     * @param exptype
     */
    public TRMapCompExpression(LexLocation location, 
        TRMapletExpression first, TRMultipleBindList bindings,
        TRExpression predicate, TRDefinition def, TRType exptype) {
        super(location, first, bindings, predicate, def, exptype);
        this.mapComp = null;//TRLambdaExpression.newMapCompExpression(first, bindings, predicate, exptype != null ? getMapType() : TRExpression.unknownType(location);
        this.existentialDomain = false;
        this.existentialRange = false;
        this.hasRangeBinding = false;
        this.domainSet   = null;
        this.rangeSet    = null;
        this.domLambda   = null;
        this.rangeLambda = null;
        this.predLambda  = null;
    }

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t");
        boolean bindingsSizeConstraint = bindings.size() > 0 && bindings.size() <= 2;
        this.existentialDomain = TRSetCompExpression.existentialComprehension(getMapletExpr().left);
        this.existentialRange = TRSetCompExpression.existentialComprehension(getMapletExpr().right);
        this.hasRangeBinding = bindingsSizeConstraint && bindings.size() == 2;

        // type bindings are okay, so long as they are uniform and 1 or 2
        if (bindings.foundBinds(TRMultipleBindKind.TYPE))
        {
            if (bindings.areBindsUniform(TRMultipleBindKind.TYPE) && bindingsSizeConstraint)
            {

            }
            else 
            {
                // mixed bindings not allowed
                //report(IsaErrorMessage.ISA_INVALID_COMPLEX_BIND_VALUE_1P); 
            }
        }
        // 1 or 2 bindings set/seq bindings is okay
        else if (bindingsSizeConstraint) 
        {

        }

        //com.fujitsu.vdmj.tc.definitions.visitors.TCGetFreeVariablesVisitor defFVV = new com.fujitsu.vdmj.tc.definitions.visitors.TCGetFreeVariablesVisitor();
        //defFVV.visitorSet ; //protected :-(
        TCGetFreeVariablesVisitor exprFVV = new TCGetFreeVariablesVisitor(
                new TCVisitorSet<TCNameToken, TCNameSet, EnvTriple>() 
                {
                    public TCExpressionVisitor<TCNameSet, EnvTriple> getExpressionVisitor()
                    {
                        return new com.fujitsu.vdmj.tc.expressions.visitors.TCGetFreeVariablesVisitor(this);
                    }                                       
                });
        EnvTriple arg = null; //new EnvTriple(?, ?, ?); 
        
        // this might have dangling bindings (i.e. if range expression is 10, get {10 | x . x : {1,2,3} } = {10,10,10} = {10} ! )
        // project out three expressions: { domExpr |-> rngExpr | .... & predExpr } 
        TRExpression domainExpr = getMapletExpr().left;
        TRExpression rangeExpr = getMapletExpr().right;
        TRExpression predExpr = predicate != null ? predicate : TRLiteralExpression.newBooleanLiteralExpression(location, true);

        // figure out the dom/rng bindings based on the discovered variables used in domain/rangeExpr
        TCNameSet domResult = new TCNameSet();//getMapletExpr().left.apply(exprFVV, arg);
        TCNameSet rngResult = new TCNameSet();
        domResult.addAll(bindings.getPatternListList().getNamesInPatternListList());
        rngResult.addAll(domResult);
        TRMultipleBindList domBindings = figureOutBindingsSubList(domResult);
        TRMultipleBindList rngBindings = figureOutBindingsSubList(rngResult);

        // create set comprehensions for dom/range sets
        this.domainSet   = new TRSetCompExpression(domainExpr.location, domainExpr, domBindings, predicate, null, domainExpr.exptype);
        this.rangeSet    = new TRSetCompExpression(rangeExpr.location, rangeExpr, rngBindings, predicate, null, rangeExpr.exptype);

        // create the lambda for each part 
        this.domLambda   = TRLambdaExpression.newLambdaExpression(figureOutMissingBindings(domBindings, domainExpr, rangeExpr), domainExpr);
        this.rangeLambda = TRLambdaExpression.newLambdaExpression(figureOutMissingBindings(rngBindings, rangeExpr, rangeExpr), rangeExpr);
        this.predLambda  = TRLambdaExpression.newLambdaExpression(figureOutMissingBindings(bindings, domainExpr, rangeExpr), predExpr);

        TRNode.setup(mapComp, domainSet, rangeSet, domLambda, rangeLambda, predLambda);
    }
    
    /**
     * mapCompSetBound lambdas *must* have two bindings! So figure out missing ones as "_::exp.type"
     * @param found
     * @param domainExpr
     * @return
     */
    private TRMultipleBindList figureOutMissingBindings(TRMultipleBindList found, TRExpression domainExpr, TRExpression rangeExpr)
    {
        TRMultipleBindList result = new TRMultipleBindList(found);
        // while (result.size() < 2)
        // {
        //     TRMultipleBind missingBind;
        //     //if (result.foundBinds(TRMultipleBindKind.TYPE))
        //     //{
        //         // cannot be dummy pattern, or isabelle considers it free variable RHS! 
        //         //    missingBind = new TRMultipleTypeBind(TRBasicPattern.underscore(exp.location), exp.getType());
        //         missingBind = new TRMultipleTypeBind(TRBasicPattern.identifier(domainExpr.location, IsaToken.dummyVarNames(1, domainExpr.location)), domainExpr.getType());
        //     //}
        //     //else 
        //     //{
        //     //    missingBind = new TRMultipleSetBind(TRBasicPattern.underscore(exp.location), ?);
        //     //}
        //     result.add(missingBind);
        // }
        int size = result.size();
        TRMultipleBind missingBind;
        switch (size)
        {
            // add corresponding bindings of the "right" type
            case 0:
                // both missing? So it's like { 10 |-> 20 | x in S, y in T }
                missingBind = new TRMultipleTypeBind(
                        TRBasicPattern.identifier(domainExpr.location, 
                            IsaToken.dummyVarNames(1, domainExpr.location) + "Dom"
                        ), 
                        domainExpr.getType());
                result.add(missingBind);
                missingBind = new TRMultipleTypeBind(
                        TRBasicPattern.identifier(rangeExpr.location, 
                            IsaToken.dummyVarNames(1, rangeExpr.location) + "Rng"
                        ), 
                        rangeExpr.getType());
                result.add(missingBind);
            case 1:
                // one is missing: figure out which one and add
                missingBind = result.get(0);
                boolean foundDomainBind = domainExpr.getType().compatible(missingBind.getRHSType());
                boolean foundRangeBind = rangeExpr.getType().compatible(missingBind.getRHSType()); 
                missingBind = foundDomainBind ? 
                            (foundRangeBind ? 
                                // compatible with both dom/ran types, add either
                                new TRMultipleTypeBind(
                                    TRBasicPattern.identifier(domainExpr.location, 
                                        IsaToken.dummyVarNames(1, domainExpr.location) + "EitherDom"
                                    ), 
                                    domainExpr.getType()) :
                                // compatible with domain and not compatible with range, add range 
                                new TRMultipleTypeBind(
                                    TRBasicPattern.identifier(rangeExpr.location, 
                                        IsaToken.dummyVarNames(1, rangeExpr.location) + "Rng"
                                    ), 
                                    rangeExpr.getType())
                            ) 
                            :
                            (foundRangeBind ? 
                                // not compatible with domain and compatible with range. add domain
                                new TRMultipleTypeBind(
                                    TRBasicPattern.identifier(domainExpr.location, 
                                        IsaToken.dummyVarNames(1, domainExpr.location) + "Dom"
                                    ), 
                                    domainExpr.getType()) 
                                :
                                // error? must be compatible with some of the two 
                                null
                            );
                if (missingBind == null)
                {
                    report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, "map comprehension", "bindings", "2", result.translate());
                }
                else
                {
                    result.add(missingBind);
                }
                break;
            case 2:
            default:
                // do nothing; nothing is missing
                break;
        }
        assert result.size() == 2;
        return result;
    }

    /**
     * From given name set within bindings, filter out those in it as the result.
     * @param names
     * @return
     */
    private TRMultipleBindList figureOutBindingsSubList(TCNameSet names)
    {
        TRMultipleBindList result = new TRMultipleBindList();
        for(TCNameToken rName : names)
        {
            TRMultipleBind rBind = bindings.findBinding(rName);
            if (rBind != null)
            {
                result.add(rBind);    
            }
            else 
            {
                report(IsaErrorMessage.ISA_INVALID_MAP_COMP_BINDING_1P, rName);
            }
        }
        return result;
    }

    @Override
    public String toString()
    {
        return super.toString() +  
            "\n\t lambda = " + String.valueOf(mapComp) +
            "\n\t dom-set= " + String.valueOf(domainSet) +
            "\n\t rng-set= " + String.valueOf(rangeSet) + 
            "\n\t dom-lda= " + String.valueOf(domLambda) +
            "\n\t rng-lda= " + String.valueOf(rangeLambda) +
            "\n\t prd-lda= " + String.valueOf(predLambda)
            ;
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
        return bindings.foundBinds(TRMultipleBindKind.TYPE) ? IsaToken.MAPCOMPTYP : IsaToken.MAPCOMPSET;
    }

    @Override
    protected TRType getBestGuessType()
    {
        return getMapletExpr().getType();
    }

    @Override
    public String translate() 
    {
        StringBuilder sb = new StringBuilder();
        // make the call to mapCompXXXBound with the synthethically constructed parameters!
        sb.append(IsaToken.comment("VDM Map comprehension is translated as a lambda-term through " + isaToken().toString(), getFormattingSeparator()));
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(domainSet.translate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(rangeSet.translate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(getMapletExpr().left.getType().invTranslate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(getMapletExpr().right.getType().invTranslate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(domLambda.translate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(rangeLambda.translate());
        sb.append(IsaToken.SPACE.toString());
        sb.append(getFormattingSeparator());
        sb.append(predLambda.translate());
        return IsaToken.parenthesise(sb.toString());
    }
    
}
