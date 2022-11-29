package annotations.po;

import com.fujitsu.vdmj.po.annotations.POAnnotation;
import com.fujitsu.vdmj.po.definitions.PODefinition;
import com.fujitsu.vdmj.po.expressions.POExpressionList;
import com.fujitsu.vdmj.pog.POContextStack;
import com.fujitsu.vdmj.pog.ProofObligationList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import com.fujitsu.vdmj.pog.ProofObligation;
import com.fujitsu.vdmj.po.definitions.POImplicitFunctionDefinition;
import com.fujitsu.vdmj.po.definitions.POImplicitOperationDefinition;
import com.fujitsu.vdmj.pog.POType;
import com.fujitsu.vdmj.po.expressions.POApplyExpression;

public class POWitnessAnnotation extends POAnnotation
{
	private static final long serialVersionUID = 1L;

	public POWitnessAnnotation(TCIdentifierToken name, POExpressionList args)
	{
		super(name, args);
	}

	//This poAfter method represents a proof of concept more than a concrete implementation of how a proof obligation can be 
	//updated with details of a witness
	@Override
	public void poAfter(PODefinition def, ProofObligationList obligations, POContextStack ctxt)
	{
		for(ProofObligation po : obligations){
			if(po.kind.equals(POType.FUNC_SATISFIABILITY)){
				POImplicitFunctionDefinition imDef = (POImplicitFunctionDefinition) def;
				String imDefResultName = imDef.result.pattern.toString();
				POApplyExpression postArg = (POApplyExpression) args.get(0);
				String postResult = postArg.args.get(args.size()-1).toString();

				String poValue = po.value;
				poValue = poValue.replaceAll(imDefResultName + ":", postResult + ":");
				poValue = poValue.replaceAll(imDefResultName + "\\)", postResult +"\\)");
				
				po.value = poValue;
			}
			else if(po.kind.equals(POType.OP_SATISFIABILITY)){
				POImplicitOperationDefinition imDef = (POImplicitOperationDefinition) def;
				if(imDef.result != null){
					String imDefResultName = imDef.result.pattern.toString();
					POApplyExpression postArg = (POApplyExpression) args.get(0);
					String postResult = postArg.args.get(args.size()-1).toString();

					String poValue = po.value;
					poValue = poValue.replaceAll(imDefResultName + ":", postResult + ":");
					poValue = poValue.replaceAll(imDefResultName + "\\)", postResult +"\\)");
				
					po.value = poValue;
				}
			}
		}			
	}
}
