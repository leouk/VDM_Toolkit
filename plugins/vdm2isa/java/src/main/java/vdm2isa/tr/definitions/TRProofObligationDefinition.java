package vdm2isa.tr.definitions;

import java.util.Arrays;

import com.fujitsu.vdmj.pog.ProofObligation;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
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
    public TRProofObligationDefinition(TRIsaVDMCommentList comments, ProofObligation po,
        TRExpression poExpr, TRType poType, TRProofScriptDefinition poScript)
    {
        this(comments, po, poExpr, poType, poScript != null ? 
            TRProofObligationDefinition.asProofScriptDefinitionList(poScript) : 
            new TRDefinitionList());
    }

    //, nameScope, used, excluded
//    protected TRDefinition(LexLocation location, TRIsaVDMCommentList comments, TCAnnotationList annotations,
 //   TCNameToken name, NameScope nameScope, boolean used, boolean excluded)

     public TRProofObligationDefinition(TRIsaVDMCommentList comments, ProofObligation po,
       TRExpression poExpr, TRType poType, TRDefinitionList poScripts)
    {
        super(po.location, comments, null, null/* po.name as TCIdentifierToken */, NameScope.GLOBAL, true, false);
        this.po = po;
        this.poExpr = poExpr;
        this.poType = poType;//always null for now, given avoiding calls to typeCheck(poExpr);
        this.poScripts = poScripts;
        if (poExpr == null)
        {
            report(IsaErrorMessage.PO_INVALID_POEXPR_2P, po.name, po.value);
        }
        setup();
    }

    @Override 
    protected void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t");
        if (poScripts != null) poScripts.setFormattingSeparator("\n\t");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ISAR_THEOREM;
    }

    @Override
    public String tldIsaComment()
    {
        return poExpr != null ? tldIsaCommentTranslate(poExpr) : "";
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
        sb.append(IsaToken.UNDERSCORE.toString());
        sb.append(po.kind.name());
        sb.append(IsaToken.COLON.toString());
        sb.append(getFormattingSeparator());
        sb.append(tldIsaComment());
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
            sb.append(TRBasicProofScriptStepDefinition.oops(location));
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
