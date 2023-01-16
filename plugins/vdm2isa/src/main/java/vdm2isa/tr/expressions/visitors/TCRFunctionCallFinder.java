package vdm2isa.tr.expressions.visitors;

import java.util.Iterator;

import com.fujitsu.vdmj.tc.expressions.TCApplyExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCFuncInstantiationExpression;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.expressions.visitors.TCFunctionCallFinder;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCBracketType;
import com.fujitsu.vdmj.tc.types.TCMapType;
import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.TypeComparator;

/**
 * Just like VDMJ's call finder, but filtering out map calls
 */
public class TCRFunctionCallFinder extends TCFunctionCallFinder {

    private final boolean linientInvCheck;

    public TCRFunctionCallFinder(boolean linientInvCheck)
    {
        super();
        this.linientInvCheck = linientInvCheck;
    }

    private final TCType ultimateType(TCType type)
    {
        TCType result = type;
        if (result instanceof TCBracketType)
        {
            result = ultimateType(((TCBracketType)result).type);
        }
        else if (result instanceof TCNamedType)
        {
            result = ultimateType(((TCNamedType)result).type);
            // while (result instanceof TCNamedType)
            // {
            //     result = ((TCNamedType)result).type;
            // }    
        }
        return result;
    }

    private TCNameToken getFunctionName(TCExpression e)
    {
        TCNameToken result = null;
        if (e instanceof TCVariableExpression)
        {
            result = ((TCVariableExpression)e).name;
        }
        else if (e instanceof TCFuncInstantiationExpression)
        {
            result = getFunctionName(((TCFuncInstantiationExpression)e).function);
        }
        return result;
    }

	@Override
	public TCNameList caseApplyExpression(TCApplyExpression node, Object arg)
	{
        TCNameList result = super.caseApplyExpression(node, arg);
        // function names occur in variable and function instantiation expressions
        TCNameToken functionName = getFunctionName(node.root);
        if (functionName != null)
        {           
            // map calls don't need to be considered given they don't have pre/post conditions
            //TODO lambda term/typed calls? They don't have pre/post either.  
            // DO NOT JUMP BETWEEN TC and TR trees!!!!
            //TRType type = (TRType)TRTypeComparator.classMap(node.type.location, node.type);
            TCType type = ultimateType(node.type);
            if (type instanceof TCMapType)
			{
                // remove the call if a map
                result.remove(functionName);  
                //TODO warn about being inside the domain?       
            }
            // linient invariant checks allow compatible/equal/narrowest types
            // to not be checked. Concretely, whether the expression type is 
            // a subtype of the declared function call parameter type
            else if (linientInvCheck)
            {
                assert node.argtypes.size() == node.args.size();
                Iterator<TCExpression> eit = node.args.iterator();
                Iterator<TCType> tit = node.argtypes.iterator();
                // presume we need to remove
                boolean remove = true;

                // stop when found no need to remove (i.e. incompatible subtypes)
                // or when checked every expression argument
                while (eit.hasNext() && remove)
                {
                    TCExpression e = eit.next();
                    TCType t = tit.next();
                    // f(x+x) will not have the invariant type check for the type of x!
                    // so only variable expressions are considered for subtyping
                    // or apply expressions (map or function)
                    remove =   
                        (
                        //  (e instanceof TCVariableExpression || 
                        //  (e instanceof TCApplyExpression && 
                        //((TCApplyExpression)e).root instanceof TCVariableExpression))   
                        //&& 
                        TypeComparator.isSubType(e.getType(), t));
                }    
                if (remove)
                {
                    result.remove(functionName);    
                }
            }

        }

        return result;
    }

}
