package annotations.po;

import com.fujitsu.vdmj.po.annotations.POAnnotation;
import com.fujitsu.vdmj.po.expressions.POExpressionList;
import com.fujitsu.vdmj.po.modules.POModule;
import com.fujitsu.vdmj.pog.POContextStack;
import com.fujitsu.vdmj.pog.ProofObligationList;
import com.fujitsu.vdmj.pog.TheoremObligation;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

public class POTheoremAnnotation extends POAnnotation {

    private static final long serialVersionUID = 1L;

    public POTheoremAnnotation(TCIdentifierToken name, POExpressionList args) {
        super(name, args);
    }

    @Override 
    public void poAfter(POModule module, ProofObligationList list)
	{
		TheoremObligation po = new TheoremObligation(module.location, args.get(0).toString(), args.get(1).toString(), new POContextStack());
        list.add(po);
	}

    
}
