package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImportedDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public class TRImportedDefinition extends TRDefinition 
{
    private static final long serialVersionUID = 1L;
    public final TRDefinition def;

    protected TRImportedDefinition(TCDefinition definition, LexLocation location, TRIsaVDMCommentList comments,
        TCAnnotationList annotations, TCNameToken name, NameScope nameScope, boolean used, boolean excluded, TRDefinition def, boolean diff) {
        super(definition, location, comments, annotations, name, nameScope, used, excluded);
        this.def = def;
    }

    public TRImportedDefinition(TCImportedDefinition definition, LexLocation location, TRIsaVDMCommentList comments,
            TCAnnotationList annotations, TCNameToken name, NameScope nameScope, boolean used, boolean excluded, TRDefinition def) {
        this(definition, location, comments, annotations, name, nameScope, used, excluded, def, false);
    }

    public TRImportedDefinition(TCImportedDefinition definition, LexLocation location, TRDefinition def) 
    {
        this(definition, location, null, null, null, NameScope.GLOBAL, definition != null ? definition.isUsed() : false, false, def);
    }

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(def);
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseImportedDefinition(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }        
}
