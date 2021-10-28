package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCSeqCompExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetCompExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindList;

/**
 * Isabelle (explicit) set compression can be defined in two different ways (implicit comprehensions exists for 
 * quantifiers, "! x : S . P" etc.):
 *      1. Simple       : Isa = "{ x . x : S /\ P }";         VDM = "{ x | x in set S & P }";
 *      2. Existential  : Isa = "{ x + x | x . x : S /\ P }"; VDM = "{ x + x | x in set S & P }"  
 *
 * Existential here in the sense that the expression is syntactic sugar for "{ u . (? x . u = x + x /\ x : S /\ P) }",
 * whenever the expression field is not a variable expression.  
 */
public class TRSetCompExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    private final TRExpression first;
    private final TRMultipleBindList binds;
    private final TRExpression predicate;
    private final boolean existential;

    public TRSetCompExpression(LexLocation location, 
        TRExpression first, TRMultipleBindList bindings, 
        TRExpression predicate)
    {
        super(location);
        this.first = first;
        this.binds = bindings;
        this.predicate = predicate;
        // if anything other than variable expression is used, we need to convert to the existential comprehension form
        this.existential = !(first instanceof TRVariableExpression);
        //System.out.println(toString());
    }

    @Override
    public String toString()
    {
        return "SetComp exp = " + first.getClass().getName() + 
            " plist (" + binds.size() + ")[" + binds.toString() + "] = " + binds.translate();  
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SET;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        // I could arguably do binds.compTranslate first if not existential? Keep it simpler? 
        sb.append(IsaToken.SET_OPEN.toString());
        sb.append(" ");
        sb.append(first.translate());
        sb.append(" ");
        sb.append(existential ? IsaToken.BAR.toString() : IsaToken.POINT.toString());
        sb.append(" ");
        this.binds.separator = " ";
        sb.append(existential ? binds.compTranslate(true) + " " + IsaToken.POINT.toString() : "");
        sb.append(" ");
        // The binds translation as the type (binding) restriction has to be part of the Isabelle predicate filter 
        this.binds.separator = " " + IsaToken.AND.toString() + " ";
        sb.append(binds.translate());
        sb.append(" ");
        if (predicate != null)
        {
            sb.append(binds.separator);
            sb.append(predicate.translate());
        }
        sb.append(" ");
        sb.append(IsaToken.SET_CLOSE.toString());
        return sb.toString();
    }

}
