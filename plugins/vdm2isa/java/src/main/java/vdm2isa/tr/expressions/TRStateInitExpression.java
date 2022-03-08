package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCStateInitExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRStateInitExpression extends TRExpression {

    private final TRStateDefinition state;

    public TRStateInitExpression(TCStateInitExpression exp, LexLocation location, TRStateDefinition state, TRType exptype) 
    {
        super(location, exp, exptype);
        this.state = state;
    }

    @Override 
    public void setup()
    {
        super.setup();
    }

    @Override 
    public String toString()
    {
        return "State init = " + String.valueOf(state);
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseStateInitExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return null;
    }

    @Override
    public String translate() {
        return "todo";
    }
}
