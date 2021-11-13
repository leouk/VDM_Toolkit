package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindList;

public class TRMultiBindListDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;
    private final TRMultipleBindList bindings;
    private final TRDefinitionList defs;

    public TRMultiBindListDefinition(LexLocation location, TRIsaVDMCommentList comments, TCAnnotationList annotations,
        TCNameToken name, NameScope nameScope, boolean used, boolean excluded, TRMultipleBindList bindings, TRDefinitionList defs)
    {
        super(location, comments, annotations, name, nameScope, used, excluded);
        this.bindings = bindings;
        this.defs = defs;
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseDefinition(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.IDENTIFIER;
    }
}
