package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCQualifiedDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.types.TRType;

public class TRQualifiedDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;

    private final TRType type;
    private final TRDefinition def;

    public TRQualifiedDefinition(TCQualifiedDefinition definition, LexLocation location, TRIsaVDMCommentList comments,
        TCAnnotationList annotations, TCNameToken name, NameScope nameScope, boolean used, boolean excluded, 
        TRDefinition def, TRType type) 
    {
        super(definition, location, comments, annotations, name, nameScope, used, excluded);
        this.def = def;
        this.type = type;    
    }

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(def, type);
    }

    @Override
    public String toString()
    {
        return "TRQualifiedDef " + 
            super.toString() +
            "\n\t def  = " + String.valueOf(def) +
            "\n\t type = " + String.valueOf(type);
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseQualifiedDefinition(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return type.isaToken();
    }

    @Override
    public String translate()
    {
        StringBuilder sb = new StringBuilder();
        sb.append("//TODO");
        return sb.toString();
    }
   
}
