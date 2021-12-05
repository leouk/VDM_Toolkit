package vdm2isa.tr.expressions;

import java.util.Arrays;
import java.util.concurrent.atomic.AtomicBoolean;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.expressions.EnvTriple;
import com.fujitsu.vdmj.tc.expressions.TCMapCompExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapEnumExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapletExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCTupleExpression;
import com.fujitsu.vdmj.tc.expressions.visitors.TCGetFreeVariablesVisitor;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TCGetFreeVariablesVisitorSet;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindKind;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.patterns.TRMultipleTypeBind;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRFunctionType;
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

    private static final int MAX_BINDINGS_ALLOWED = 2;
    private TRExpression mapComp;
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
    public TRMapCompExpression(LexLocation location, TCMapCompExpression exp,  
        TRMapletExpression first, TRMultipleBindList bindings,
        TRExpression predicate, TRDefinition def, TRType exptype) {
        super(location, exp, first, bindings, predicate, def, exptype);
        this.mapComp = null;
        this.domainSet   = null;
        this.rangeSet    = null;
        this.domLambda   = null;
        this.rangeLambda = null;
        this.predLambda  = null;
    }

    protected static enum TRMapCompExprKind { DOMAIN, RANGE, PRED }

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t");
        boolean bindingsSizeConstraint = bindings.size() > 0 && bindings.size() <= MAX_BINDINGS_ALLOWED;
        // this.existentialDomain = TRSetCompExpression.existentialComprehension(getMapletExpr().left);
        // this.existentialRange = TRSetCompExpression.existentialComprehension(getMapletExpr().right);
        // this.hasRangeBinding = bindingsSizeConstraint && bindings.size() == MAX_BINDINGS_ALLOWED;

        // type bindings are okay, so long as they are uniform and 1 or 2
        if (bindings.foundBinds(TRMultipleBindKind.TYPE))
        {
            if (bindings.areBindsUniform(TRMultipleBindKind.TYPE) && bindingsSizeConstraint)
            {
                // 1 o 2 type bindings is okay; but will lead to hard PO on finiteness warn
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
            // okay, no trouble
        }

        // project out three expressions: { domExpr |-> rngExpr | .... & predExpr } 
        TRExpression domainExpr = getMapletExpr().left;
        TRType domainType = domainExpr.getType();
        TRExpression rangeExpr = getMapletExpr().right;
        TRType rangeType = rangeExpr.getType();

        // predicate might be null at this point; use it
        if (TRMapCompExpression.isTrivial(domainExpr, rangeExpr, predicate))
        {
            TCMapletExpressionList tcMapletList = new TCMapletExpressionList();
            tcMapletList.add(getMapletExpr().maplet);
            this.mapComp = new TRMapEnumExpression(location, 
                new TCMapEnumExpression(location, tcMapletList),
                new TRMapletExpressionList(Arrays.asList(getMapletExpr())), getType());
        }
        else 
        {
            this.mapComp = null; 

            // setup a free variables visitor
            // { let x = f(y) in x + y |-> 10 | .... }
            TCGetFreeVariablesVisitor exprFVV = new TCGetFreeVariablesVisitor(new TCGetFreeVariablesVisitorSet());
            EnvTriple env = new EnvTriple(new FlatEnvironment(new TCDefinitionList()), new FlatEnvironment(new TCDefinitionList()), new AtomicBoolean(false)); 

            // figure out the dom/rng bindings based on the discovered variables used in domain/rangeExpr
            // this presumes the "TCExpression" patch up as a tuple done by TRMapletExpression 
            // if the predicate has more FV than dom/rng, then it will compromise the set creation
            // { x+y |-> 10 | x in set S, y in set T & x > y and (x+y) < z }
            // { x + y | x in set S, y in set T & x > y and (x+y) < z } for domain!
            //TCTupleExpression tp = (TCTupleExpression)getMapletExpr().getVDMExpr();
            TCNameSet domFV = getMapletExpr().maplet.left.apply(exprFVV, env);
            TCNameSet rngFV = getMapletExpr().maplet.right.apply(exprFVV, env);
            TCNameSet prdFV = new TCNameSet(); //predicate != null ? predicate.getVDMExpr().apply(exprFVV, env) : new TCNameSet();
            TCNameSet unboundFV = TRMapCompExpression.figureOutUnboundFV(bindings, domFV, rngFV);//, prdFV);
            if (!unboundFV.isEmpty())
            {
                // warn about unbound FV possibly leading to issues? 
                //warning(IsaWarningMessage.);
            }
            // prdFV / (domFV union rngFV) <> {} means issues; but unboundFV will catch that
            //prdFV.removeAll(domFV);
            //prdFV.removeAll(rngFV);
            //if (prdFV.retainAll(domFV))
            //{
            //}
            

            // create set enum.comprehensions for dom/range sets
            this.domainSet = TRMapCompExpression.figureOutSet(bindings, domFV, domainExpr, predicate, TRMapCompExprKind.DOMAIN);
            this.rangeSet  = TRMapCompExpression.figureOutSet(bindings, rngFV, rangeExpr, predicate, TRMapCompExprKind.RANGE);

            // have to figure out lambda bindings based on the intersection between 
            // declared bindings and FV ones (remainder are true free variables).
            boolean hasEasyDom = TRMapCompExpression.hasEasyLambda(domainExpr);
            boolean hasEasyRng = TRMapCompExpression.hasEasyLambda(rangeExpr);
                // even with fv in the pred, needs to evaluate it anyhow, e.g. 3 > 5? 
            boolean hasEasyPrd = TRMapCompExpression.isTrivialPred(predicate);//hasEasyLambda(predicate, prdFV);
            TRExpression predExpr = predicate != null ? predicate : TRLiteralExpression.newBooleanLiteralExpression(location, true);
            // figureout lambda bindings if necessary (i.e. any hard lambdas needed)
            TRMultipleBindList lambdaBindings = !hasEasyDom || !hasEasyRng || !hasEasyPrd ?
                TRMapCompExpression.figureOutLambdaBindings(bindings, domFV, domainType, rngFV, rangeType, prdFV) : null;
            
            // create the lambda for each part, where set/seq bindings are transformed into corresponding type binds 
            // i.e. we can "reuse" map comp bindings even if set/seq, as lambda will figure out right type bind list
            if (hasEasyDom)
            {
                this.domLambda = TRMapCompExpression.figureOutEasyLambdas(domainExpr, TRMapCompExprKind.DOMAIN);
            }
            else 
            {
                //figureOutMissingBindings(lambdaBindings, domainExpr, rangeExpr)?
                this.domLambda   = TRLambdaExpression.newLambdaExpression(lambdaBindings, domainExpr);
            }

            if (hasEasyRng)
            {
                this.rangeLambda = TRMapCompExpression.figureOutEasyLambdas(rangeExpr, TRMapCompExprKind.RANGE);
            }
            else
            {
                this.rangeLambda = TRLambdaExpression.newLambdaExpression(lambdaBindings, rangeExpr);
            }

            if (hasEasyPrd)
            {
                this.predLambda = TRMapCompExpression.figureOutEasyLambdas(predExpr, TRMapCompExprKind.PRED);
            }
            else 
            {
                this.predLambda  = TRLambdaExpression.newLambdaExpression(lambdaBindings, predExpr);
            }

        }

        TRNode.setup(mapComp, domainSet, rangeSet, domLambda, rangeLambda, predLambda);
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
        return bindings.foundBinds(TRMultipleBindKind.TYPE) ? IsaToken.MAPCOMP_TYPBOUND : IsaToken.MAPCOMP_SETBOUND;
    }

    @Override
    protected TRType getBestGuessType()
    {
        return getMapletExpr().getType();
    }

    protected boolean isTrivial()
    {
        return mapComp != null;
    }

    @Override
    public String translate() 
    {
        StringBuilder sb = new StringBuilder();
        if (isTrivial())
        {
            assert mapComp != null;
            sb.append(mapComp.translate());
        }
        else
        {
            assert mapComp == null;
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
        }
        return IsaToken.parenthesise(sb.toString());
    }
    
        /**
     * Trivial map comp { 1 |-> 10 | x in S, y in T & P } = { 1 |-> 10 }
     * @param domainExpr
     * @param rangeExpr
     * @return
     */
    private static boolean isTrivial(TRExpression domainExpr, TRExpression rangeExpr, TRExpression pred)
    {
        return domainExpr instanceof TRLiteralExpression && 
                rangeExpr instanceof TRLiteralExpression && 
                isTrivialPred(pred);
    }

    private static boolean isTrivialPred(TRExpression pred)
    {
        return pred == null || 
              (pred instanceof TRLiteralExpression && 
                ((TRLiteralExpression)pred).exp.equals(IsaToken.TRUE.toString()));
    }

    private static TCNameSet figureOutUnboundFV(TRMultipleBindList given, TCNameSet... args)
    {
        TCNameSet result = new TCNameSet();
        for(TCNameSet ns : args)
        {
            for(TCNameToken n : ns)
            {
                // of all FV names, those not bound are truly free 
                if (given.findBinding(n) == null)
                {
                    result.add(n);
                }
            }
        }
        return result;
    }

    private static TRExpression figureOutSet(TRMultipleBindList given, TCNameSet fv, TRExpression expr, TRExpression pred, TRMapCompExprKind kind)
    {
        assert expr != null && given != null && fv != null;
        TRExpression result;
        // for literals, it's just an singleton enumeration
        if (expr instanceof TRLiteralExpression)
        {
            result = TRSetEnumExpression.newSetEnumExpression(expr.location, 
                new TRExpressionList(Arrays.asList(expr)), expr.getType());
        }
        else 
        {
            TRMultipleBindList setbindings = TRMapCompExpression.figureOutBindPart(given, fv, expr.getType(), kind);
            result = TRSetCompExpression.newSetCompExpression(expr.location, expr, setbindings, pred, null, expr.getType());
        }
        return result;
    }

    private static boolean hasEasyLambda(TRExpression easyExpr)
    {
        return (easyExpr != null && 
                    (easyExpr instanceof TRLiteralExpression || 
                        easyExpr instanceof TRVariableExpression));
    }

    private static TRApplyExpression figureOutEasyLambdas(TRExpression easyExpr, TRMapCompExprKind kind)
    {
        assert easyExpr instanceof TRLiteralExpression || easyExpr instanceof TRVariableExpression;
        String original = null; 
        TRFunctionType fcnType = null;
        TRType t = easyExpr.getType();
        TRExpressionList args = new TRExpressionList();
        if (kind.equals(TRMapCompExprKind.PRED))
        {
            assert (t instanceof TRBasicType) && ((TRBasicType)t).isBooleanType();
            if (easyExpr instanceof TRLiteralExpression)
            {
                // truecnst: 'a => 'b => bool
                // for us, just () -> bool
                original = IsaToken.MAPCOMP_TRUECNST.toString(); 
                fcnType = TRFunctionType.newConstantFunctionType(t);
            }
            else
            {
                original = IsaToken.MAPCOMP_PREDCNST.toString();
                fcnType = TRFunctionType.newConstantFunctionType(t);
                args.add(easyExpr);
                // // maybe better error msg later; pred can't be a variable and easy? 
                // GeneralisaPlugin.report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, 
                //     easyExpr.location, "map comp", "predicate", "0", original);
            }
        }
        else
        {
            if (easyExpr instanceof TRLiteralExpression)
            {
                switch (kind)
                {
                    case DOMAIN: 
                        // domcnst: 'a => 'a => 'b => 'a
                        // for our purposes, it's just 'a -> 'a    
                        original = IsaToken.MAPCOMP_DOMCNST.toString(); 
                        fcnType = TRFunctionType.newFunctionType(t, t);
                        args.add(easyExpr);
                        break; 
                    case RANGE : 
                        original = IsaToken.MAPCOMP_RNGCNST.toString(); 
                        fcnType = TRFunctionType.newFunctionType(t, t);
                        args.add(easyExpr);
                        break;
                    case PRED :
                        throw new InternalError("impoosible");
                }    
            }
            else if (easyExpr instanceof TRVariableExpression)
            {
                switch (kind)
                {
                    case DOMAIN: 
                        // domid: 'a => 'b => 'a (or 'a * 'b -> 'a); 
                        // but for our purposes inside vdm2isa, it's just () -> 'a
                        original = IsaToken.MAPCOMP_DOMID.toString(); 
                        fcnType = TRFunctionType.newConstantFunctionType(t);
                        break; 
                    case RANGE : 
                        original = IsaToken.MAPCOMP_RNGID.toString(); 
                        fcnType = TRFunctionType.newConstantFunctionType(t);
                        break;
                    case PRED :
                        throw new InternalError("impoosible");
                }    
            }
        }
        assert original != null && fcnType != null; 
        TRVariableExpression root = TRVariableExpression.newVariableExpr(easyExpr.location, original, fcnType);
        TRApplyExpression result = TRApplyExpression.newApplyExpression(root, args, t);
        return result;
    }

    private static TRMultipleBind newDummyTypeBind(TRMapCompExprKind kind, TRType exprType)
    {
        return TRMultipleTypeBind.newMultipleTypeBind(
                        TRBasicPattern.identifier(exprType.location, 
                            IsaToken.dummyVarNames(1, exprType.location) + kind.name()
                            ), 
                        exprType);
    }
    
    private static TRMultipleBind figureOutDummyBind(TRMultipleBind found, TRType exprType, TRMapCompExprKind kind)
    {
        TRMultipleBind result = found;
        // if bind is found, use that as the bind          
        if (result != null)
        {
            // if type compatible (by set or type bind) is found; that's the one
            // otherwise, issue a dummy name on the expr type as the bind 
            // (e.g. for the case { mk_R(x,y) |-> 10 | x in S, y in T }, where neither x nor y are dom type)!
            if (exprType != null && !result.getRHSType().compatible(exprType))
            {
                result = TRMapCompExpression.newDummyTypeBind(kind, exprType);
            }
            // exprType = null for predExpr, given it's about it's inner bind
        }
        // otherwise carry on trying to find; patch up later in  case none is found (i.e. truly free variables in expr!)
        return result;
    }

    private static TRMultipleBindList figureOutBindPart(TRMultipleBindList given, TCNameSet varsToBind, TRType exprType, TRMapCompExprKind kind)
    {
        TRMultipleBindList result = new TRMultipleBindList();
        for(TCNameToken v : varsToBind)
        {
            TRMultipleBind b = TRMapCompExpression.figureOutDummyBind(given.findBinding(v), exprType, kind);
            if (b != null)
                result.add(b);
        }
        assert result.size() <= given.size();
        return result;
    }

    private static TRMultipleBindList figureOutMissingBinding(TRMultipleBindList result, TRType type, TRMapCompExprKind kind)
    {
        if (result.isEmpty())
        {
            result.add(TRMapCompExpression.newDummyTypeBind(kind, type));
        }
        assert !result.isEmpty();
        return result;
    }

    /**
     * From the given bindings, see which of the free variables in the dom/rng/pred expressions need binding.
     * This will be the basis of the lambda expressions to be created. 
     * @param given
     * @param varsToBind
     * @param exprType
     * @return
     */
    private static TRMultipleBindList figureOutLambdaBindings(TRMultipleBindList given, TCNameSet domVarsToBind, TRType domType, TCNameSet rngVarsToBind, TRType rngType, TCNameSet prdVarsToBind)
    {
        assert !domVarsToBind.isEmpty() || !rngVarsToBind.isEmpty() || !prdVarsToBind.isEmpty();
        TRMultipleBindList result = new TRMultipleBindList();
        
        TRPatternListList allBoundPatterns = given.getPatternListList();
        if (!allBoundPatterns.uniqueNames())
        {
            // non unique names
            given.report(IsaErrorMessage.ISA_INVALID_MAP_COMP_BINDING_1P, given.translate()); 
        } 

        TRMultipleBindList domBindings = TRMapCompExpression.figureOutBindPart(given, domVarsToBind, domType, TRMapCompExprKind.DOMAIN);
        domBindings = TRMapCompExpression.figureOutMissingBinding(domBindings, domType, TRMapCompExprKind.DOMAIN);
        //assert domBindings.size() == 1;

        TRMultipleBindList rngBindings = TRMapCompExpression.figureOutBindPart(given, rngVarsToBind, rngType, TRMapCompExprKind.RANGE);
        rngBindings = TRMapCompExpression.figureOutMissingBinding(rngBindings, rngType, TRMapCompExprKind.RANGE);
        //assert rngBindings.size() == 1;

        result.addAll(domBindings);
        result.addAll(rngBindings);
        if (result.size() < TRMapCompExpression.MAX_BINDINGS_ALLOWED)
        {
            // figure out predicate, if not all bindings allowed were found 
            // (i.e. { 1 |-> 5 | x in set {1,2,3} & x > 5 } example )

            TRMultipleBindList prdBindings;
    
            // remove the already bound variables from the predicate variables to bind
            prdVarsToBind.removeAll(domVarsToBind);
            prdVarsToBind.removeAll(rngVarsToBind);
            if (!prdVarsToBind.isEmpty())
            {
                // warn: only predicate binds variable?! Which type? *must* find on the given bind!
                prdBindings = TRMapCompExpression.figureOutBindPart(given, prdVarsToBind, null, TRMapCompExprKind.PRED); 
                if (prdBindings.size() != prdVarsToBind.size())
                {
                    // couldn't find prd binding to bind with; free var?
                    //TODO change error message
                    given.report(IsaErrorMessage.ISA_INVALID_MAP_COMP_BINDING_1P, prdBindings.translate()); 
                }
                else 
                    result.addAll(prdBindings);
            }
        }

        // whatever happens, make sure it's properly figured out (i.e. nor smaller, nor bigger)
        if (result.size() != TRMapCompExpression.MAX_BINDINGS_ALLOWED)
        {
            // couldn't find prd binding to bind with; free var?
            //TODO change error message
            given.report(IsaErrorMessage.ISA_INVALID_MAP_COMP_BINDING_1P, result.translate()); 
        }

        return result;
    }
}
