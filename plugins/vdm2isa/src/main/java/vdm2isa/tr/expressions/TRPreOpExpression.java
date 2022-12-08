package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCPreOpExpression;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;


public class TRPreOpExpression extends TRExpression{

    TCNameToken opname; 
    TRStateDefinition state;
    TRExpression expression;
    
    public TRPreOpExpression(TCPreOpExpression preOp, LexLocation location, TRType exptype,TCNameToken opname, TRExpression expression, TRStateDefinition state) 
    {
        super(location, preOp, exptype);
        this.opname = opname;
        this.state = state;
        this.expression = expression;
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.casePreOpExpression(this, arg);
    }

    @Override
    public String oldtranslate() {
        return expression.oldtranslate();
    }

    @Override
    public IsaToken isaToken()
    {
        return IsaToken.EOF;
    }
}
