package plugins;

import com.fujitsu.vdmj.Release;
import com.fujitsu.vdmj.Settings;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

/**
 * Determines what kind of implicit specification is associated with some top level definition, 
 * where multiple values may apply. See TCNameToken for corresponding/similar list of such 
 * implicit names. It is also possible to have no name. 
 */
public enum VDMSpecificationKind {
    NONE, PRE, POST, INV, EQ, ORD, MAX, MIN, INIT, MEASURE;
    
	/**
	 * Determines wether this TRExplicitFunctionDefinition is one of those constructed by the typechecker.
	 * Depending on which kind (if any), then translation has to take into account different considerations. 
	 * Decision is based on VDM naming conventions (e.g., pre_, post_, inv_, ord_, eq_, etc.).
	 * @return the kind of implicit specification associated with this definition
	 */
    public static final VDMSpecificationKind figureOutSpecificationKind(TCNameToken name)
	{
		VDMSpecificationKind result = VDMSpecificationKind.NONE;

		// presumes Settings.release = VDM_10 and dialect = VDMSL. 
        // This is supposed to be checked by GeneralisaPlugin.run anyhow
        assert (Settings.release == Release.VDM_10 && Settings.dialect == Dialect.VDM_SL); 

		if (name.isReserved())
		{
			String fcnName = name.getName();
			if (fcnName.startsWith("pre_")) 
				result = VDMSpecificationKind.PRE;
			else if (fcnName.startsWith("post_"))
				result = VDMSpecificationKind.POST;
			else if (fcnName.startsWith("inv_"))
				result = VDMSpecificationKind.INV;
			else if (fcnName.startsWith("init_"))
				result = VDMSpecificationKind.INIT;
			else if (fcnName.startsWith("measure_"))
				result = VDMSpecificationKind.MEASURE;
			else if (fcnName.startsWith("eq_"))
				result = VDMSpecificationKind.EQ;
			else if (fcnName.startsWith("ord_"))
				result = VDMSpecificationKind.ORD;
			else if (fcnName.startsWith("min_"))
				result = VDMSpecificationKind.MIN;
			else if (fcnName.startsWith("max_"))	
				result = VDMSpecificationKind.MAX;
		}
		return result;
	} 
}
