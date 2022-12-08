package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCStateInitExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;


public class TRStateInitExpression extends TRExpression {

    private TRStateDefinition state;

    //This has no access to information as in VDMJ it is purely used as a type checker and nothing else. 
    //All of the logic is in StateDefinition
    public TRStateInitExpression(TCStateInitExpression tc, TRType exptype, TRStateDefinition state) {
        super(tc != null && tc.location != null ? tc.location : LexLocation.ANY, (TCExpression)tc, exptype);
        this.state = state;
    }

    @Override
    public void setup()
    {
        super.setup();
    }

    @Override
    public String toString(){
        return super.toString();
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.createStateInitExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String oldtranslate() {
        if(IsaToken.from(state.getInitExpression().op).equals(IsaToken.EQUALS)){
            return state.getInitExpression().right.oldtranslate();
        }else{
            return state.getInitExpression().oldtranslate();
       }
    }

}
