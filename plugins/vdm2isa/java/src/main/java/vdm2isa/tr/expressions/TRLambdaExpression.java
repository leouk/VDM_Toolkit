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
        StringBuilder sb = new StringBuilder();
        // lambda x: nat, y: nat1 & x + y
        // =
        // (% (x::VDMNat) (y::VDMNat1) . 
        //      (if (inv_VDMNat x) /\ (inv_VDMNat1 y) then
        //          (x + y)
        //       else 
        //          undefined
        //      )
        // )
        sb.append("\n\t");
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(bindList.translate());
        sb.append(IsaToken.POINT.toString());
        sb.append("\n\t\t");
        sb.append(IsaToken.LPAREN.toString());
        sb.append(IsaToken.IF.toString());
        sb.append(" ");
        sb.append(bindList.invTranslate());
        sb.append(" ");
        sb.append(IsaToken.THEN.toString());
        sb.append("\n\t\t\t");
        sb.append(expression.translate());        
        sb.append("\n\t\t ");
        sb.append(IsaToken.ELSE.toString());
        sb.append("\n\t\t\t");
        sb.append(IsaToken.UNDEFINED.toString());
        sb.append("\n\t\t"); 
        sb.append(IsaToken.RPAREN.toString());
        sb.append("\n\t");
        return IsaToken.parenthesise(sb.toString());
    }
}
