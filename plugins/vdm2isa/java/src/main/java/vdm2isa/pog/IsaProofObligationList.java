package vdm2isa.pog;

import java.util.Collections;
import java.util.Map;
import java.util.TreeMap;
import java.util.Vector;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import plugins.Pog2isaPlugin;
import vdm2isa.tr.definitions.TRProofScriptDefinition;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRExpressionList;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRProofObligationDefinition;
import vdm2isa.tr.modules.TRModuleList;
import vdm2isa.tr.modules.TRProofObligationModule;

/**
 * Class to manage a flat list of PO definitions into a TRModuleList (i.e. POs per module) 
 */
public class IsaProofObligationList extends Vector<TRProofObligationDefinition> {
    
    private Map<String, TRDefinitionList> poModuleMap;

    public IsaProofObligationList()
    {
        super();
        this.poModuleMap = new TreeMap<String, TRDefinitionList>();
    }

    /**
     * Get the mapped PO list for the given module, creating one if it doesn't exist. 
     * @param module
     * @return
     */
    protected TRDefinitionList getModulePOList(String module)
    {
        TRDefinitionList modulePOS;
        if (!poModuleMap.containsKey(module))
        {
            modulePOS = new TRDefinitionList();   
            poModuleMap.put(module, modulePOS);  
        }
        else
        {
            modulePOS = poModuleMap.get(module);
        }
        return modulePOS;
    }

    /**
     * Construct a map with all the POs for the ProofObligations of the same module within this list.
     * This is a type conversion from a flat list of pairs to a map of lists for each module. 
     * @return
     */
    public TRModuleList getModulePOs() {
        poModuleMap.clear();
        // type transform this list of POs into a corresponding maps of lists per module
        for (TRProofObligationDefinition pod : this)
        {
            TRDefinitionList poList = getModulePOList(pod.po.location.module);
            poList.add(pod);
        } 

        // create the module list view of the this proof obligation definition list
        TRModuleList result = new TRModuleList();
        if (!checkAllDefinitionsArePOS())
            Pog2isaPlugin.report(11111, "Invalid module PO list: only PO expressions or proofs scripts are allowed", LexLocation.ANY);
        else
        {
            // create PO modules per TRDefininitionList of POs or PSs for the correspoding PO module name 
            for(String module : poModuleMap.keySet())
            {
                result.add(new TRProofObligationModule(
                        new TCIdentifierToken(null, IsaTemplates.getPOModuleName(module), false), 
                        poModuleMap.get(module)));
            }
        }

        return result;
    }

    private boolean checkAllDefinitionsArePOS()
    {
        for(TRDefinitionList pos : poModuleMap.values())
        {
            for(TRDefinition po : pos)
            {
                if (po instanceof TRProofObligationDefinition || 
                    po instanceof TRProofScriptDefinition)
                    return false; 
            }
        }
        return true;
    }
}
