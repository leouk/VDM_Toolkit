package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindKind;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;

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
        TRExpression predicate, TRType exptype)
    {
        super(location, exptype);
        this.first = first;
        this.binds = bindings;
        this.predicate = predicate;
        // if anything other than variable expression is used, we need to convert to the existential comprehension form
        this.existential = !(first instanceof TRVariableExpression);
        //System.out.println(toString());
    }

    @Override 
    protected void setup()
    {
        super.setup();
        setFormattingSeparator(" ");
    }

    @Override
    public String toString()
    {
        if (first != null && binds != null)
            return "SetComp exp = " + first.getClass().getSimpleName() + 
                " plist (" + binds.size() + ") = " + String.valueOf(binds);// + "] = " + binds.translate();  
        else 
            return "SetComp exp = " + (first != null ? first.getClass().getSimpleName() : "null") +
                " plist(0) = null";
    }

    @Override
    public TRType getType()
    {
        return new TRSetType(location, new TRDefinitionList(), first.getType(), false);
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
        sb.append(getFormattingSeparator());
        sb.append(first.translate());
        sb.append(getFormattingSeparator());
        sb.append(existential ? IsaToken.BAR.toString() : IsaToken.POINT.toString());
        sb.append(getFormattingSeparator());
        String old = binds.setSemanticSeparator(" ");
        sb.append(existential ? binds.compTranslate(true) + getFormattingSeparator() + IsaToken.POINT.toString() : "");
        sb.append(getFormattingSeparator());
        // The binds translation as the type (binding) restriction has to be part of the Isabelle predicate filter 
        binds.setSemanticSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());

        // type bound set comprehension will lead to heavy PO!
        if (binds.foundBinds(TRMultipleBindKind.TYPE))
        {
            warning(IsaWarningMessage.VDMSL_SETCOMP_TYPEBOUND);
            sb.append(IsaToken.comment(IsaWarningMessage.VDMSL_SETCOMP_TYPEBOUND.message, getFormattingSeparator()));
        }

        // call inv translate as type binds require inv_T binds in the pattern, whereas set/seq is just translate (don't)
        String bindStr = binds.invTranslate();
        if (!bindStr.isEmpty())
        {
            sb.append(getFormattingSeparator());
            sb.append(binds.invTranslate());
            sb.append(getFormattingSeparator());
        }
        if (predicate != null)
        {
            sb.append(binds.getSemanticSeparator());
            sb.append(predicate.translate());
        }

        sb.append(getFormattingSeparator());
        sb.append(IsaToken.SET_CLOSE.toString());
        
        binds.setSemanticSeparator(old);
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSetCompExpression(this, arg);
	}
}
