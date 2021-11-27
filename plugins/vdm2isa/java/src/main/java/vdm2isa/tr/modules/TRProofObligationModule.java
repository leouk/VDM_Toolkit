package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

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
    public TRProofObligationModule(String poModuleOwner, TCIdentifierToken poModuleName, TRDefinitionList definitions)
    {
        super(poModuleName, definitions, TRModule.asFileList(poModuleName.getLocation() != null ? poModuleName.getLocation().file : null));
        this.poModuleOwner = poModuleOwner;
    }

    /**
     * Isabelle POs file imports the PO module owner's Isabelle file of the same name. 
     */
    public String getImports()
	{
		return poModuleOwner;
	}
}
