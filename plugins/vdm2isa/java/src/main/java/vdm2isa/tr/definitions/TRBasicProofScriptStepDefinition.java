package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public class TRBasicProofScriptStepDefinition extends TRDefinition {
    
    private static final long serialVersionUID = 1L;

    private final IsaToken isarScriptStep;

    protected TRBasicProofScriptStepDefinition(LexLocation location, TRIsaVDMCommentList comments, IsaToken isarScriptStep)
    {
        super(null, location, comments, null, null, NameScope.GLOBAL, true, false);
        this.isarScriptStep = isarScriptStep;
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseBasicProofScriptStepDefinition(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return isarScriptStep;
    }

    @Override
    public String translate()
    {
        return isaToken().toString() + getFormattingSeparator();
    }

    protected static final TRBasicProofScriptStepDefinition newBasicProofScriptStepDefinition(LexLocation location, IsaToken token)
    {
        TRBasicProofScriptStepDefinition result = new TRBasicProofScriptStepDefinition(location, null, token);
        TRNode.setup(result);
        return result;
    }

    protected static final TRBasicProofScriptStepDefinition sledgehammer(LexLocation location)
    {
        return TRBasicProofScriptStepDefinition.newBasicProofScriptStepDefinition(location, IsaToken.ISAR_SLEDGEHAMMER);
    }
    
    protected static final TRBasicProofScriptStepDefinition nitpick(LexLocation location)
    {
        return TRBasicProofScriptStepDefinition.newBasicProofScriptStepDefinition(location, IsaToken.ISAR_NITPICK);
    }
    
    protected static final TRBasicProofScriptStepDefinition isaTry0(LexLocation location)
    {
        return TRBasicProofScriptStepDefinition.newBasicProofScriptStepDefinition(location, IsaToken.ISAR_TRY0);
    }

    protected static final TRBasicProofScriptStepDefinition isaTry(LexLocation location)
    {
        return TRBasicProofScriptStepDefinition.newBasicProofScriptStepDefinition(location, IsaToken.ISAR_TRY);
    }

    protected static final TRBasicProofScriptStepDefinition done(LexLocation location)
    {
        return TRBasicProofScriptStepDefinition.newBasicProofScriptStepDefinition(location, IsaToken.ISAR_DONE);
    }
    
    protected static final TRBasicProofScriptStepDefinition oops(LexLocation location)
    {
        return TRBasicProofScriptStepDefinition.newBasicProofScriptStepDefinition(location, IsaToken.ISAR_OOPS);
    }    

}
