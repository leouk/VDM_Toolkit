package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCPostOpExpression;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;


public class TRPostOpExpression extends TRExpression{

    TCNameToken opname; 
    TRStateDefinition state;
    TRExpression preexpression;
    TRExpression postexpression;

    
    public TRPostOpExpression(TCPostOpExpression preOp, LexLocation location, TRType exptype,TCNameToken opname, TRExpression preexpression, TRExpression postexpression, TRStateDefinition state) 
    {
        super(location, preOp, exptype);
        this.opname = opname;
        this.state = state;
        this.preexpression = preexpression;
        this.postexpression = postexpression;
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.casePostOpExpression(this, arg);
    }

    @Override
    public String oldtranslate() {
        return postexpression.oldtranslate();
    }

    @Override
    public IsaToken isaToken()
    {
        return IsaToken.EOF;
    }
}
