package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.patterns.TRTypeBindList;

public class TRLambdaExpression extends TRExpression {

    private TRTypeBindList bindList;
    private TRExpression expression;

    public TRLambdaExpression(LexLocation location, TRTypeBindList bindList, TRExpression expression)
    {
        super(location);
        this.bindList = bindList;
        this.expression = expression;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.LAMBDA;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(isaToken().toString() + " " + 
            bindList.translate() + IsaToken.POINT + " " + expression.translate());
    }
}
