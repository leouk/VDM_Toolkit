package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;

import plugins.IsapogPlugin;
import vdm2isa.lex.IsaItem;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
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

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n");
    }

    /**
     * Isabelle POs file imports the PO module owner's Isabelle file of the same name. 
     */
    @Override
    public String getImports()
	{
		return poModuleOwner;
	}

    @Override
    protected boolean moduleMatches(String fileName)
    {
        return poModuleOwner.equals(fileName);
        //return poModuleOwner.startsWith(fileName) && poModuleOwner.equals(IsaTemplates.getPOModuleName(fileName));
    }

    @Override 
    public String getPostScript()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaTemplates.translatePOGLocale(getLocation()));
        sb.append(getFormattingSeparator());
        sb.append(getFormattingSeparator());
        String interpretation = null;
        String script = null;//null=defaultScript; IsaToken.ISAR_OOPS.toString();
        sb.append(IsaTemplates.translatePOGLocaleInterpreation(getLocation(), IsapogPlugin.createPOGLocaleInterpretationLemmas, interpretation, script));
        return sb.toString();
    }

    public static final TRModule newProofObligationModule(String owner, TRDefinitionList pos) {
        TRModule result = new TRProofObligationModule(
                new TCModule(
                    null, //annotations 
                    new TCIdentifierToken(pos.getLocation(), owner, false), 
                    null, //imports
                    null, //exports 
                    pos.getVDMDefinitionList(), //defs
                    TRModule.asFileList(pos.getLocation().file), //file
                    false), //flat
                new TCIdentifierToken(pos.getLocation(), IsaTemplates.getPOModuleName(owner), false), 
                    pos);
        TRNode.setup(result);
        return result;
    }
}
