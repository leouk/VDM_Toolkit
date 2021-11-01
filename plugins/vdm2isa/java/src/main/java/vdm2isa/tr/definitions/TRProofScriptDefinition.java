package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRProofScriptDefinition extends TRDefinition {

	private static final long serialVersionUID = 1L;

    private TRProofScriptStepDefinitionList poScript;

    public TRProofScriptDefinition(LexLocation location, TRIsaCommentList comments,
        TRProofScriptStepDefinitionList poScript)
    {
        super(location, comments, null);
        this.poScript = poScript;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ISAR_PROOF;
    }

    @Override
    public String translate() {
        return poScript.translate();
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseProofScriptDefinition(this, arg);
    }
    
    /**
     * Creates an optimistic proof script delegating the proof to sledgehammer then oopsing (done?) it
     * @param location
     * @return
     */
    public static TRProofScriptDefinition optimistic(LexLocation location)
    {
        TRProofScriptDefinition result = new TRProofScriptDefinition(location, 
            TRIsaCommentList.newComment(location, "Hope Sldegehammer can help", false), 
            TRProofScriptStepDefinitionList.proofScript(
                TRBasicProofScriptStepDefinition.sledgehammer(location),
                TRBasicProofScriptStepDefinition.oops(location))
            );
        return result;
    }
}
