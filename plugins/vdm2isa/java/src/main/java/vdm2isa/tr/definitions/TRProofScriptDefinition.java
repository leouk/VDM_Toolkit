package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public class TRProofScriptDefinition extends TRDefinition {

	private static final long serialVersionUID = 1L;

    private TRProofScriptStepDefinitionList poScript;

    public TRProofScriptDefinition(LexLocation location, TRIsaVDMCommentList comments,
        TRProofScriptStepDefinitionList poScript)
    {
        super(null, location, comments, null, null, NameScope.GLOBAL, true, false);
        this.poScript = poScript;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(poScript);
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
     * Creates an optimistic proof script delegating the proof to the try0 method then oopsing (done?) it
     * @param location
     * @return
     */
    public static TRProofScriptDefinition optimistic(LexLocation location)
    {
        TRProofScriptDefinition result = new TRProofScriptDefinition(location, 
            TRIsaVDMCommentList.newComment(location, "Expect the goal is trivial", false), 
            TRProofScriptStepDefinitionList.proofScript(
                TRBasicProofScriptStepDefinition.isaTry0(location),
                TRBasicProofScriptStepDefinition.oops(location))
            );
        return result;
    }

    /**
     * Creates hopeful proof script delegating the proof to sledgehammer then oopsing (done?) it
     * @param location
     * @return
     */
    public static TRProofScriptDefinition hopeful(LexLocation location)
    {
        TRProofScriptDefinition result = new TRProofScriptDefinition(location, 
            TRIsaVDMCommentList.newComment(location, "Expect sldegehammer can find the proof", false), 
            TRProofScriptStepDefinitionList.proofScript(
                TRBasicProofScriptStepDefinition.sledgehammer(location),
                TRBasicProofScriptStepDefinition.oops(location))
            );
        return result;
    }

    /**
     * Creates a pessimistic proof script expecting nitpick will find a counter example
     * @param location
     * @return
     */
    public static TRProofScriptDefinition pessimistic(LexLocation location)
    {
        TRProofScriptDefinition result = new TRProofScriptDefinition(location, 
            TRIsaVDMCommentList.newComment(location, "Expect Nitpick can find a counter example", false), 
            TRProofScriptStepDefinitionList.proofScript(
                TRBasicProofScriptStepDefinition.nitpick(location),
                TRBasicProofScriptStepDefinition.oops(location))
            );
        return result;
    }

    /**
     * Creates a realistic proof script attempting all tools in the box (including try0, nitpick and sledgehammer) 
     * @param location
     * @return
     */
    public static TRProofScriptDefinition realistic(LexLocation location)
    {
        TRProofScriptDefinition result = new TRProofScriptDefinition(location, 
            TRIsaVDMCommentList.newComment(location, "Try to be optimisstic, hopeful, then pessimistic", false), 
            TRProofScriptStepDefinitionList.proofScript(
                TRBasicProofScriptStepDefinition.isaTry(location),
                TRBasicProofScriptStepDefinition.oops(location))
            );
        return result;
    }

    /**
     * Creates a proof script that accepts defeat against the PO
     * @param location
     * @return
     */
    public static TRProofScriptDefinition surrender(LexLocation location)
    {
        TRProofScriptDefinition result = new TRProofScriptDefinition(location, 
            TRIsaVDMCommentList.newComment(location, "Surrender", false), 
            TRProofScriptStepDefinitionList.proofScript(
                TRBasicProofScriptStepDefinition.oops(location))
            );
        return result;
    }

}
