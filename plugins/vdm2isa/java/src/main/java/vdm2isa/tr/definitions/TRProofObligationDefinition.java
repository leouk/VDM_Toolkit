package vdm2isa.tr.definitions;

import java.util.Arrays;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.pog.POType;
import com.fujitsu.vdmj.pog.ProofObligation;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRType;

public class TRProofObligationDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;
   
    public final ProofObligation po;
    public final int poNumber; // po.number is not helpful
    public final TRExpression poExpr;
    public final TRType poType;
    private TRDefinitionList poScripts;

    private static final LexLocation figureOutLocation(ProofObligation po)
    {
        return po != null ? po.location : LexLocation.ANY;
    }

    /**
     * Creates a proof obligation for the given ProofObligation. It corresponds to the transformation of 
     * the type checked PO string mapped and type checked to a TRExpression and its resulting TRType. 
     * @param location
     * @param comments
     * @param poExpr
     * @param poScript
     */
    public TRProofObligationDefinition(TRIsaVDMCommentList comments, ProofObligation po,
        TRExpression poExpr, TRType poType, int poNumber, TRProofScriptDefinition poScript)
    {
        this(comments, po, poExpr, poType, poNumber, poScript != null ? 
            TRProofObligationDefinition.asProofScriptDefinitionList(poScript) : 
            new TRDefinitionList());
    }

    //, nameScope, used, excluded
//    protected TRDefinition(LexLocation location, TRIsaVDMCommentList comments, TCAnnotationList annotations,
 //   TCNameToken name, NameScope nameScope, boolean used, boolean excluded)

     public TRProofObligationDefinition(TRIsaVDMCommentList comments, ProofObligation po,
       TRExpression poExpr, TRType poType, int poNumber, TRDefinitionList poScripts)
    {
        super(null, figureOutLocation(po), comments, null, IsaToken.newNameToken(figureOutLocation(po), figureOutLocation(po).module, "PO_" + po != null ? String.valueOf(po.name) : "null"), NameScope.GLOBAL, true, false);
        this.po = po;
        this.poExpr = poExpr;
        this.poType = poType;// always poExpr.getType() equivalent, now we have PO.getCheckedExpression()
        this.poNumber = poNumber;
        this.poScripts = poScripts;
    }

    @Override 
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t");
        if (poExpr == null)
        {
            report(IsaErrorMessage.PO_INVALID_POEXPR_2P, po.name, po.value);
        }

        TRNode.setup(poExpr, poType, poScripts);
        if (poScripts != null) 
        {
            poScripts.setFormattingSeparator("\n\t");
        }
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

    private boolean figureOutIgnorePO(String poNameStr, String poExprStr, POType kind)
    {
        boolean result = false;
        // measure-related POs are spurious given Isabelle's recursive definition principles
        result = (poNameStr.indexOf("measure_") != -1 && 
                  poExprStr.indexOf("measure_") != -1 &&
                  kind.equals(POType.TOTAL)
                 )
                 ||
                 //this name was just something in gateway.vdmsl
                 (//poNameStr.indexOf("rest_p") != -1 &&
                  poExprStr.indexOf("measure_") != -1 &&
                  kind.equals(POType.RECURSIVE)
                ); 
        return result;
    }

    @Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
        // get comments etc.
        sb.append(super.translate());

        // replace all names with "$" signs as Isabelle doesn't like them.
        String poExprStr = poExpr.translate().replaceAll("\\$", "dollar");
        // Some PO names are "Gateway; rest_p" etc; fix those to be proper identifiers
        String poNameStr = po.name.replaceAll("; ", IsaToken.UNDERSCORE.toString());

        boolean ignorePO = figureOutIgnorePO(poNameStr, poExprStr, po.kind);

        // declare the theorem with the PO's name
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(poNameStr);
        sb.append(IsaToken.UNDERSCORE.toString());
        sb.append(po.kind.name());
        sb.append(IsaToken.UNDERSCORE.toString());
        sb.append(IsaToken.PO.toString());
        sb.append(poNumber);
        sb.append(IsaToken.COLON.toString());
        sb.append(getFormattingSeparator());
        sb.append(tldIsaComment());
        sb.append(IsaToken.innerSyntaxIt(IsaToken.parenthesise(poExprStr)));
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

        // if ignoring the PO still issue its translation as an isabelle block comment
        if (ignorePO)
        {
            StringBuilder ignore = new StringBuilder();
            ignore.append(getFormattingSeparator());
            ignore.append(IsaToken.comment(IsaInfoMessage.PO_IGNORE_PO_2P.format(poNameStr, "measures"), getFormattingSeparator()));
            ignore.append(sb.toString());
            ignore.append(getFormattingSeparator());
            return IsaToken.bracketit(IsaToken.BLOCK_COMMENT_OPEN, ignore.toString(), IsaToken.BLOCK_COMMENT_CLOSE);
        }
        else
        {
            return sb.toString();
        }
	}

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseProofObligationDefinition(this, arg);
    }

    public static final TRDefinitionList asProofScriptDefinitionList(TRProofScriptDefinition... args)
	{
		TRDefinitionList result = new TRDefinitionList();
		if (args != null)
            result.addAll(Arrays.asList(args));
        TRNode.setup(result);
		return result;
	}

    public static final TRProofObligationDefinition newProofObligationDefinition(TRIsaVDMCommentList comments, ProofObligation po,
    TRExpression poExpr, TRType poType, int poNumber, TRProofScriptDefinition... poScripts)
    {
        TRProofObligationDefinition result = new TRProofObligationDefinition(comments, po, poExpr, poType, poNumber,
            TRProofObligationDefinition.asProofScriptDefinitionList(poScripts));
        TRNode.setup(result);
        return result;
    }

    public static final TRProofObligationDefinition newProofObligationDefinition(TRIsaVDMCommentList comments, ProofObligation po,
        TRExpression poExpr, TRType poType, int poNumber, TRDefinitionList poScripts)
    {
        TRProofObligationDefinition result = new TRProofObligationDefinition(comments, po, poExpr, poType, poNumber, poScripts);
        TRNode.setup(result);
        return result;
    }

}
