package vdm2isa.tr.definitions;

import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.pog.ProofObligation;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRType;

public class TRProofObligationDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;
   
    public final ProofObligation po;
    public final TRExpression poExpr;
    public final TRType poType;
    private TRDefinitionList poScripts;

    /**
     * Creates a proof obligation for the given ProofObligation. It corresponds to the transformation of 
     * the type checked PO string mapped and type checked to a TRExpression and its resulting TRType. 
     * @param location
     * @param comments
     * @param poExpr
     * @param poScript
     */
    public TRProofObligationDefinition(TRIsaCommentList comments, ProofObligation po,
        TRExpression poExpr, TRType poType, TRProofScriptDefinition poScript)
    {
        this(comments, po, poExpr, poType, TRProofObligationDefinition.asProofScriptDefinitionList(poScript));
    }

    public TRProofObligationDefinition(TRIsaCommentList comments, ProofObligation po,
       TRExpression poExpr, TRType poType, TRDefinitionList poScripts)
    {
        super(po.location, comments, null);
        this.po = po;
        this.poExpr = poExpr;
        this.poType = poType;
        this.poScripts = poScripts;
    }

    @Override 
    protected void setup()
    {
        setFormattingSeparator("\n\t");
        poScripts.setFormattingSeparator("\n\t");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.THEOREM;
    }

    @Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
        // get comments etc.
        sb.append(super.translate());

        // declare the theorem with the PO's name
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(po.name);
        sb.append(IsaToken.COLON.toString());
        sb.append(getFormattingSeparator());
        sb.append(IsaToken.innerSyntaxIt(IsaToken.parenthesise(poExpr.translate())));
        sb.append(getFormattingSeparator());
        
        // translate the script if it exists or oops it
        if (poScripts != null && !poScripts.isEmpty())
        {
            // translate the proof script as well
            sb.append(getFormattingSeparator());
            sb.append(poScripts.translate());
        }
        else
        {
            sb.append(IsaToken.OOPS.toString());
        }
        sb.append(getFormattingSeparator());
        return sb.toString();
	}

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseProofObligationDefinition(this, arg);
    }

    public static TRDefinitionList asProofScriptDefinitionList(TRProofScriptDefinition args)
	{
		TRDefinitionList result = new TRDefinitionList();
		result.addAll(Arrays.asList(args));
		return result;
	}

}
