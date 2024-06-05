package vdm2isa.tr.modules;

import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;

import plugins.IsaProperties;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRProofObligationDefinition;

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

        // Normalise PO number for sorting in locale to match "string" name
        figureOutTotalPOs();
    }

    //TODO this is terrible :-(. Need a good revamp of all this. Perhaps bring out of IsaTemplate the Locale POG stuff? 
    private final void figureOutTotalPOs()
    {
        int totalPOs = 0;
        for (TRDefinition d : this.allDefs)
        {
            if (d instanceof TRProofObligationDefinition) totalPOs++;
        }
        assert totalPOs <= this.allDefs.size();
        for (TRDefinition d : this.allDefs)
        {
            if (d instanceof TRProofObligationDefinition)
            {
                TRProofObligationDefinition pod = (TRProofObligationDefinition)d;
                pod.totalPOs = totalPOs;
            }
        }
    }

    /**
     * Isabelle POs file imports the PO module owner's Isabelle file of the same name. 
     */
    @Override
    public List<String> getImports()
	{
		return Arrays.asList(poModuleOwner);
	}

    @Override
    public String getOldImports()
	{
		return poModuleOwner;
	}

    @Override
    protected boolean moduleMatches(String fileName)
    {
        return poModuleOwner.equals(fileName);
        //return poModuleOwner.startsWith(fileName) && poModuleOwner.equals(IsaTemplates.getPOModuleName(fileName));
    }

    /**
     * For proo obligation module, we have to consider the proof scripts of interest per definition. 
     */
    @Override 
    public String getPostScript()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaTemplates.translatePOGLocale(getLocation()));
        
        sb.append(getFormattingSeparator());
        sb.append(getFormattingSeparator());
        String interpretation = null;
        String script = null;//null=defaultScript; IsaToken.ISAR_OOPS.toString();
        sb.append(IsaTemplates.translatePOGLocaleInterpreation(getLocation(), IsaProperties.isapog_create_pog_locale_interpretation_lemmas, interpretation, script));
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
