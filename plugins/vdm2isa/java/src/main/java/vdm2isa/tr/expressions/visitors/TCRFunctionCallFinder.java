package vdm2isa.tr.expressions.visitors;

import java.util.Iterator;

import com.fujitsu.vdmj.tc.expressions.TCApplyExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.expressions.visitors.TCFunctionCallFinder;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.types.TCMapType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.TypeComparator;

import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeComparator;

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
        // map calls don't need to be considered given they don't have pre/post conditions
        //TODO lambda term/typed calls? They don't have pre/post either.  
        TRType type = (TRType)TRTypeComparator.classMap(node.type.location, node.type);
        if (node.root instanceof TCVariableExpression && type.ultimateType() instanceof TRMapType)//(node.type instanceof TCMapType))
        {
            TCVariableExpression vexp = (TCVariableExpression)node.root;
			result.remove(vexp.name);        
        }

        assert node.argtypes.size() == node.args.size();
        Iterator<TCExpression> eit = node.args.iterator();
        Iterator<TCType> tit = node.argtypes.iterator();
        while (eit.hasNext())
        {
            TCExpression e = eit.next();
            TCType t = tit.next();
            //TODO when to remove the check from the result? 
            boolean b = TypeComparator.compatible(t, e.getType());
        }

        return result;
    }

}
