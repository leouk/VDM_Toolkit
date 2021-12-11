package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCRenamedDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public class TRRenamedDefinition extends TRImportedDefinition {

    public TRRenamedDefinition(TCRenamedDefinition definition, LexLocation location, TRIsaVDMCommentList comments,
            TCAnnotationList annotations, TCNameToken name, boolean used, boolean excluded,
            TRDefinition def) 
    {
        super(definition, location, comments, annotations, name, def != null ? def.nameScope : NameScope.GLOBAL, used, excluded, def, false);
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseRenamedDefinition(this, arg);
    }
}
