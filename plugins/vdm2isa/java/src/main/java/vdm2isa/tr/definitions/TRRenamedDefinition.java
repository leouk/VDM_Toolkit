package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCRenamedDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;

public class TRRenamedDefinition extends TRImportedDefinition {

    public TRRenamedDefinition(TCRenamedDefinition definition, LexLocation location, TRIsaVDMCommentList comments,
            TCAnnotationList annotations, TCNameToken name, boolean used, boolean excluded,
            TRDefinition def) 
    {
        super(definition, location, comments, annotations, name, def != null ? def.nameScope : NameScope.GLOBAL, used, excluded, def, false);
    }

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\n");
    } 

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseRenamedDefinition(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ABBREVIATION;
    }        

    @Override
    public String translate()
    {
        StringBuilder sb = new StringBuilder();
        String newName = IsaToken.isabelleName(name);
        String oldName = IsaToken.isabelleName(def.name); //TODO do I need to say def.name.module.toString + "." + def.name.toString()? Maybe
        String importStr = 
            newName + 
            IsaToken.SPACE.toString() + 
            IsaToken.EQUALSEQUALS.toString() + 
            IsaToken.SPACE.toString() + 
            oldName;
        sb.append(super.translate());
        sb.append(IsaToken.comment(IsaInfoMessage.VDM_RENAMED_IMPORT_3P.format(def.name.getModule(), oldName, newName), getFormattingSeparator()));
        sb.append(isaToken());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.bracketit(IsaToken.ISAQUOTE, importStr, IsaToken.ISAQUOTE));
        sb.append(getFormattingSeparator());
        return sb.toString();
    }

}
