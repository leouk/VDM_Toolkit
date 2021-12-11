package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;

public class TRProofObligationModule extends TRModule
{
	private static final long serialVersionUID = 1L;

    public final String poModuleOwner;

    /**
     * This is created by the IsaProofObligationsList class with the module responsible for generating this PO module.
     * The module name itself is important to be TCIdentifierToken because of location information needed.
     * @param poModuleOwner
     * @param poModuleName
     * @param definitions
     */
    public TRProofObligationModule(TCModule owner, TCIdentifierToken poModuleName, TRDefinitionList definitions)
    {
        super(owner, null, null, 
            poModuleName, null, null, definitions, TRModule.asFileList(poModuleName != null ? poModuleName.getLocation() != null ? poModuleName.getLocation().file : null : null));
        this.poModuleOwner = owner.name.toString();
    }

    /**
     * Isabelle POs file imports the PO module owner's Isabelle file of the same name. 
     */
    public String getImports()
	{
		return poModuleOwner;
	}

    public static final TRModule newProofObligationModule(String owner, TRDefinitionList pos) {
        TCIdentifierToken name = new TCIdentifierToken(pos.getLocation(), IsaTemplates.getPOModuleName(owner), false);
        TRModule result = new TRProofObligationModule(
                new TCModule(
                    null, //annotations 
                    name, 
                    null, //imports
                    null, //exports 
                    pos.getVDMDefinitionList(), //defs
                    TRModule.asFileList(pos.getLocation().file), //file
                    false), //flat
                name, pos);
        TRNode.setup(result);
        return result;
    }
}
