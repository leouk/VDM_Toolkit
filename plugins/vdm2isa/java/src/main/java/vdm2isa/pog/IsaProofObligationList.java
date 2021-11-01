package vdm2isa.pog;

import java.util.Collections;
import java.util.Map;
import java.util.TreeMap;
import java.util.Vector;

import vdm2isa.tr.expressions.TRExpressionList;
import vdm2isa.tr.expressions.TRProofObligationExpression;

public class IsaProofObligationList extends Vector<TRProofObligationExpression> {
    
    private Map<String, TRExpressionList> modulePOmap;

    public IsaProofObligationList()
    {
        super();
        this.modulePOmap = new TreeMap<String, TRExpressionList>();
    }

    /**
     * Get the mapped PO list for the given module, creating one if it doesn't exist. 
     * @param module
     * @return
     */
    protected TRExpressionList getModulePOList(String module)
    {
        TRExpressionList modulePOS;
        if (!modulePOmap.containsKey(module))
        {
            modulePOS = null;//new TRExpressionList();   
            modulePOmap.put(module, modulePOS);  
        }
        else
        {
            modulePOS = modulePOmap.get(module);
        }
        return modulePOS;
    }

    /**
     * Construct a map with all the POs for the ProofObligations of the same module within this list.
     * This is a type conversion from a flat list of pairs to a map of lists for each module. 
     * @return
     */
    public Map<String, TRExpressionList> getModulePOs() {
        modulePOmap.clear();
        // type transform this list of POs into a corresponding maps of lists per module
        for (TRProofObligationExpression pair : this)
        {
            TRExpressionList poList = getModulePOList(pair.po.location.module);
            poList.add(pair.poExpr);
        } 
        return Collections.unmodifiableMap(modulePOmap);
    }
}
