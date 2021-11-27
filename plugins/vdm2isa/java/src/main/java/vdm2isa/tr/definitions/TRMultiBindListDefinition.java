package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCMultiBindListDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindList;

public class TRMultiBindListDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;
    private final TRMultipleBindList bindings;
    private final TRDefinitionList defs;

    public TRMultiBindListDefinition(TCMultiBindListDefinition definition, LexLocation location, TRIsaVDMCommentList comments, TCAnnotationList annotations,
        TCNameToken name, NameScope nameScope, boolean used, boolean excluded, TRMultipleBindList bindings, TRDefinitionList defs)
    {
        super(definition, location, comments, annotations, name, nameScope, used, excluded);
        this.bindings = bindings;
        this.defs = defs;
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(bindings, defs);
    }

    @Override
	public String toString()
	{
		return "MultiBindListDef " + 
            "\n\t bindings = " + String.valueOf(bindings) + 
            "\n\t defs     = " + String.valueOf(defs) + 
            super.toString();
	}


    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseDefinition(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.IDENTIFIER;
    }

    public TRMultipleBindList getBindings()
    {
        return bindings;
    }

    public static TRMultiBindListDefinition newBindListDef(LexLocation location, 
        TRMultipleBindList bindings)
    {
        return new TRMultiBindListDefinition(null, location, null, null, null, null, true, false, 
            bindings, bindings.getDefinitions());
    }
}
