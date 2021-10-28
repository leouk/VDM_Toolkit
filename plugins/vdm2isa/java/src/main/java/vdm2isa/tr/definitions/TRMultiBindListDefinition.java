package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.patterns.TRMultipleBindList;

//TODO delete
public class TRMultiBindListDefinition extends TRDefinition {
    
    private final TRMultipleBindList bindings;
    private final TRDefinitionList defs;
    
    public TRMultiBindListDefinition(LexLocation location, TRMultipleBindList bindings, TRDefinitionList defs)
    {
        super(location, null);
        this.bindings = bindings;
        this.defs = defs;
        System.out.println("\n\t\tMultiBindListDef" + 
            "\n\t\t\t bindings: " + bindings.translate() + 
            "\n\t\t\t defs    : " + defs.translate() +
            "\n");
    }
}
