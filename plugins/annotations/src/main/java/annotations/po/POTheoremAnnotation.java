package annotations.po;

import java.util.Arrays;

import com.fujitsu.vdmj.po.annotations.POAnnotation;
import com.fujitsu.vdmj.po.definitions.PODefinition;
import com.fujitsu.vdmj.po.expressions.POExpressionList;
import com.fujitsu.vdmj.po.expressions.POVariableExpression;
import com.fujitsu.vdmj.po.modules.POModule;
import com.fujitsu.vdmj.pog.POContextStack;
import com.fujitsu.vdmj.pog.PONameContext;
import com.fujitsu.vdmj.pog.ProofObligationList;
import com.fujitsu.vdmj.pog.TheoremObligation;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.lex.TCNameList;

public class POTheoremAnnotation extends POAnnotation {

    private static final long serialVersionUID = 1L;

    public POTheoremAnnotation(TCIdentifierToken name, POExpressionList args) {
        super(name, args);
    }

    @Override 
    public void poAfter(PODefinition def, ProofObligationList obligations, POContextStack ctxt)
	{
        //@NB TheoremObligation doesn't make use of the name argument? Does it need to go into ctxt?
        //    From the output this is not quite right, but wasn't sure the way forward on this one. 
        assert args.get(0) instanceof POVariableExpression;
        POVariableExpression poName = (POVariableExpression)args.get(0);
        ctxt.push(new PONameContext(new TCNameList(poName.name)));

		TheoremObligation po = new TheoremObligation(def.location, poName.name.toString(), args.get(1).toString(), ctxt);
        obligations.add(po);  
	}
}
