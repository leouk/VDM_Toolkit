package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public class TRProofScriptStepDefinition extends TRDefinition {

    private static final long serialVersionUID = 1L;

    private final String proofStep;

    public TRProofScriptStepDefinition(LexLocation location, TRIsaVDMCommentList comments, String proofStep)
    {
        super(null, location, comments, null, null, NameScope.GLOBAL, true, false);
        this.proofStep = proofStep;
    }

    @Override
    public void setup()
    {
        super.setup();
        setSemanticSeparator(IsaToken.SPACE.toString());
        setFormattingSeparator("\n\t");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ISAR_APPLY;
    }

    @Override
	public String translate()
	{
        StringBuilder sb = new StringBuilder();
		sb.append(translatePreamble());
        sb.append(isaToken().toString());
        sb.append(getSemanticSeparator());
        sb.append(proofStep);
        sb.append(getFormattingSeparator());
        return sb.toString();
	}

   @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseProofScriptStepDefinition(this, arg);
    }
 }
