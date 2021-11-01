package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public class TRBasicProofScriptStepDefinition extends TRDefinition {
    
    private static final long serialVersionUID = 1L;

    private final IsaToken isarScriptStep;

    protected TRBasicProofScriptStepDefinition(LexLocation location, TRIsaCommentList comments, IsaToken isarScriptStep)
    {
        super(location, comments);
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

    protected static final TRBasicProofScriptStepDefinition sledgehammer(LexLocation location)
    {
        return new TRBasicProofScriptStepDefinition(location, null, IsaToken.ISAR_SLEDGEHAMMER);
    }
    
    protected static final TRBasicProofScriptStepDefinition nitpick(LexLocation location)
    {
        return new TRBasicProofScriptStepDefinition(location, null, IsaToken.ISAR_NITPICK);
    }
    
    protected static final TRBasicProofScriptStepDefinition isaTry0(LexLocation location)
    {
        return new TRBasicProofScriptStepDefinition(location, null, IsaToken.ISAR_TRY0);
    }

    protected static final TRBasicProofScriptStepDefinition isaTry(LexLocation location)
    {
        return new TRBasicProofScriptStepDefinition(location, null, IsaToken.ISAR_TRY);
    }

    protected static final TRBasicProofScriptStepDefinition done(LexLocation location)
    {
        return new TRBasicProofScriptStepDefinition(location, null, IsaToken.ISAR_DONE);
    }
    
    protected static final TRBasicProofScriptStepDefinition oops(LexLocation location)
    {
        return new TRBasicProofScriptStepDefinition(location, null, IsaToken.ISAR_OOPS);
    }    

}
