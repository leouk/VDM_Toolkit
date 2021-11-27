package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinition;
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
public class TRSetCompExpression extends TRAbstractCompExpression {
    private static final long serialVersionUID = 1L;

    private boolean existential;

    public TRSetCompExpression(LexLocation location, 
        TRExpression first, TRMultipleBindList bindings, 
        TRExpression predicate, TRDefinition def, TRType exptype)
    {
        super(location, first, bindings, predicate, def, exptype);
        // if anything other than variable expression is used, we need to convert to the existential comprehension form
        this.existential = first != null && !(first instanceof TRVariableExpression);
        //System.out.println(toString());
    }

    @Override
    public void setup()
    {
        super.setup();
        this.existential = first != null && !(first instanceof TRVariableExpression);
    }

    @Override
    protected TRType getBestGuessType()
    {
        return new TRSetType(exptype.getVDMType(), new TRDefinitionList(), first.getType(), false);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.SET;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        
        // I could arguably do bindings.compTranslate first if not existential? Keep it simpler? 
        sb.append(IsaToken.SET_OPEN.toString());
        sb.append(getFormattingSeparator());
        
        sb.append(first.recordPatternTranslate(bindings));
        
        sb.append(getFormattingSeparator());
        sb.append(existential ? IsaToken.BAR.toString() : IsaToken.POINT.toString());
        sb.append(getFormattingSeparator());
        String old = bindings.setSemanticSeparator(" ");
        sb.append(existential ? bindings.compTranslate(true) + getFormattingSeparator() + IsaToken.POINT.toString() : "");
        sb.append(getFormattingSeparator());
        // The bindings translation as the type (binding) restriction has to be part of the Isabelle predicate filter 
        bindings.setSemanticSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());

        // type bound set comprehension will lead to heavy PO!
        if (bindings.foundBinds(TRMultipleBindKind.TYPE))
        {
            warning(IsaWarningMessage.VDMSL_SETCOMP_TYPEBOUND);
            sb.append(getFormattingSeparator() + IsaToken.comment(IsaWarningMessage.VDMSL_SETCOMP_TYPEBOUND.message, getFormattingSeparator()));
        }

        // call inv translate as type bindings require inv_T bindings in the pattern, whereas set/seq is just translate (don't)
        String bindStr = bindings.invTranslate();
        if (!bindStr.isEmpty())
        {
            sb.append(getFormattingSeparator());
            sb.append(bindStr);
            sb.append(getFormattingSeparator());
        }
        if (predicate != null)
        {
            sb.append(bindings.getSemanticSeparator());

            sb.append(predicate.recordPatternTranslate(bindings));
        }

        sb.append(getFormattingSeparator());
        sb.append(IsaToken.SET_CLOSE.toString());
        
        bindings.setSemanticSeparator(old);
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSetCompExpression(this, arg);
	}
}
