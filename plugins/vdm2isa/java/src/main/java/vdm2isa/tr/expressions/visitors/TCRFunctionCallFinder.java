package vdm2isa.tr.expressions.visitors;

import com.fujitsu.vdmj.tc.expressions.TCApplyExpression;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.expressions.visitors.TCFunctionCallFinder;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.types.TCMapType;

/**
 * Just like VDMJ's call finder, but filtering out map calls
 */
public class TCRFunctionCallFinder extends TCFunctionCallFinder {

    public TCRFunctionCallFinder()
    {
        super();
    }

	@Override
	public TCNameList caseApplyExpression(TCApplyExpression node, Object arg)
	{
        TCNameList result = super.caseApplyExpression(node, arg);
        // map calls don't need to be considered
        if (node.root instanceof TCVariableExpression && (node.type instanceof TCMapType))
        {
            TCVariableExpression vexp = (TCVariableExpression)node.root;
			result.remove(vexp.name);        
        }

        return result;
    }

}
