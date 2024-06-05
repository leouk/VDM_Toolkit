package vdm2isa.tr.expressions.visitors;

import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.expressions.TRApplyExpression;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRFunctionInstantiationExpression;
import vdm2isa.tr.expressions.TRVariableExpression;
import vdm2isa.tr.types.TRMapType;

public class TRFunctionCallFinder extends TRLeafExpressionVisitor<TCNameToken, TCNameList, Object>
{
    public TRFunctionCallFinder()
    {
        super();
    }

    @Override
    public TCNameList caseExpression(TRExpression node, Object arg)
    {
        return newCollection();
    }

    protected TCNameList figureOutCallType(TRVariableExpression vexp, TCNameList result)
    {
        assert result != null;
        result.add(vexp.name);
        return result;
    }
    
    @Override
    public TCNameList caseApplyExpression(TRApplyExpression node, Object arg)
    {
        TCNameList result = newCollection();

        if (node.root instanceof TRVariableExpression && !(node.type instanceof TRMapType))
        {
            TRVariableExpression vexp = (TRVariableExpression)node.root;
            result.add(vexp.name);
        }
        else if (node.root instanceof TRFunctionInstantiationExpression)
        {
            TRFunctionInstantiationExpression fie = (TRFunctionInstantiationExpression)node.root;

            if (fie.function instanceof TRVariableExpression)
            {
                TRVariableExpression vexp = (TRVariableExpression)fie.function;
                result.add(vexp.name);
            }
        }

        result.addAll(super.caseApplyExpression(node, arg));
        return result;
    }

    @Override
    protected TCNameList newCollection()
    {
        return new TCNameList();
    }    
}
